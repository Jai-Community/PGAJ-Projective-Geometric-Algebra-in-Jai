//Dual Quaternion: line, rotation, translation, or screw motion
Dq :: #type,distinct [8]float;

oneDq : Dq : .[1.,0.,0.,0., 0.,0.,0.,0.];
#run logj(oneDq);

//Flector: point, plane... and some other things
Fl :: #type,distinct [8]float;

//fl functions
operator * :: (a:Fl, b:Dq) -> Fl
{
    ret:Fl;

    ret[0] = + b[0] * a[0] - b[1] * a[1] - b[2] * a[2] - b[3] * a[3] + b[4] * a[4] + b[5] * a[5] + b[6] * a[6] + b[7] * a[7];
    ret[1] = + b[0] * a[1] - b[4] * a[2] + b[5] * a[3] - b[6] * a[7];
    ret[2] = + b[4] * a[1] + b[0] * a[2] - b[6] * a[3] - b[5] * a[7];
    ret[3] = - b[5] * a[1] + b[6] * a[2] + b[0] * a[3] - b[4] * a[7];

    ret[4] = - b[4] * a[0] + b[2] * a[1] - b[1] * a[2] + b[7] * a[3] + b[0] * a[4] + b[6] * a[5] - b[5] * a[6] + b[3] * a[7];
    ret[5] = - b[5] * a[0] - b[3] * a[1] + b[7] * a[2] + b[1] * a[3] - b[6] * a[4] + b[0] * a[5] + b[4] * a[6] + b[2] * a[7];
    ret[6] = - b[6] * a[0] + b[7] * a[1] + b[3] * a[2] - b[2] * a[3] + b[5] * a[4] - b[4] * a[5] + b[0] * a[6] + b[1] * a[7];
    ret[7] = + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] + b[0] * a[7];

    return ret;
}

operator + :: (a:Fl, b:Fl) -> Fl
{
    ret:Fl;

    //the planar reflection part
    ret[0] = a[0] + b[0]; ret[1] = a[1] + b[1]; ret[2] = a[2] + b[2]; ret[3] = a[3] + b[3];

    //the point part
    ret[4] = a[4] + b[4]; ret[5] = a[5] + b[5]; ret[6] = a[6] + b[6]; ret[7] = a[7] + b[7];

    return ret;
}

meet :: (a:Fl, b:Dq) -> Fl
{
    ret:Fl;

    ret[0] = + b[0] * a[0];
    ret[1] = + b[0] * a[1];
    ret[2] = + b[0] * a[2];
    ret[3] = + b[0] * a[3];

    ret[4] = - b[4] * a[0] + b[2] * a[1] - b[1] * a[2] + b[0] * a[4];
    ret[5] = - b[5] * a[0] - b[3] * a[1] + b[1] * a[3] + b[0] * a[5];
    ret[6] = - b[6] * a[0] + b[3] * a[2] - b[2] * a[3] + b[0] * a[6];
    ret[7] = + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] + b[0] * a[7];

    return ret;
}

inner :: (a:Fl, b:Dq) -> Fl
{
    ret:Fl;
    ret[0] = + b[0] * a[0] - b[1] * a[1] - b[2] * a[2] - b[3] * a[3] + b[4] * a[4] + b[5] * a[5] + b[6] * a[6] + b[7] * a[7];
    ret[1] = + b[0] * a[1] - b[4] * a[2] + b[5] * a[3] - b[6] * a[7];
    ret[2] = + b[4] * a[1] + b[0] * a[2] - b[6] * a[3] - b[5] * a[7];
    ret[3] = - b[5] * a[1] + b[6] * a[2] + b[0] * a[3] - b[4] * a[7];

    ret[4] = + b[7] * a[3] + b[0] * a[4];
    ret[5] = + b[7] * a[2] + b[0] * a[5];
    ret[6] = + b[7] * a[1] + b[0] * a[6];
    ret[7] = + b[0] * a[7];

    return ret;
}

operator * :: (a:Fl, b:Fl) -> Dq
{
    ret:Dq;
    ret[0] = + b[1] * a[1] + b[2] * a[2] + b[3] * a[3] - b[7] * a[7];

    ret[1] = + b[1] * a[0] - b[0] * a[1] - b[4] * a[2] + b[5] * a[3] - b[2] * a[4] + b[3] * a[5] + b[7] * a[6] - b[6] * a[7];
    ret[2] = + b[2] * a[0] + b[4] * a[1] - b[0] * a[2] - b[6] * a[3] + b[1] * a[4] + b[7] * a[5] - b[3] * a[6] - b[5] * a[7];
    ret[3] = + b[3] * a[0] - b[5] * a[1] + b[6] * a[2] - b[0] * a[3] + b[7] * a[4] - b[1] * a[5] + b[2] * a[6] - b[4] * a[7];
    ret[4] = + b[2] * a[1] - b[1] * a[2] + b[7] * a[3] + b[3] * a[7];
    ret[5] = - b[3] * a[1] + b[7] * a[2] + b[1] * a[3] + b[2] * a[7];
    ret[6] = + b[7] * a[1] + b[3] * a[2] - b[2] * a[3] + b[1] * a[7];

    ret[7] = + b[7] * a[0] + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] - b[3] * a[4] - b[2] * a[5] - b[1] * a[6] - b[0] * a[7];

    return ret;
}

meet :: (a:Fl, b:Fl) -> Dq {

    ret:Dq;
    ret[0] = 0.;

    ret[1] = + b[1] * a[0] - b[0] * a[1];
    ret[2] = + b[2] * a[0] - b[0] * a[2];
    ret[3] = + b[3] * a[0] - b[0] * a[3];
    ret[4] = + b[2] * a[1] - b[1] * a[2];
    ret[5] = - b[3] * a[1] + b[1] * a[3];
    ret[6] = + b[3] * a[2] - b[2] * a[3];

    ret[7] = + b[7] * a[0] + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] - b[3] * a[4] - b[2] * a[5] - b[1] * a[6] - b[0] * a[7];

    return ret;
}

inner :: (a:Fl, b:Fl) -> Dq {

    ret:Dq;
    ret[0] = + b[1] * a[1] + b[2] * a[2] + b[3] * a[3] - b[7] * a[7];

    ret[1] = - b[4] * a[2] + b[5] * a[3] - b[2] * a[4] + b[3] * a[5];
    ret[2] = + b[4] * a[1] - b[6] * a[3] + b[1] * a[4] - b[3] * a[6];
    ret[3] = - b[5] * a[1] + b[6] * a[2] - b[1] * a[5] + b[2] * a[6];
    ret[4] = + b[7] * a[3] + b[3] * a[7];
    ret[5] = + b[7] * a[2] + b[2] * a[7];
    ret[6] = + b[7] * a[1] + b[1] * a[7];

    ret[7] = 0.;

    return ret;
}

getReverse :: (a:Fl) -> Fl {

    ret:Fl;
    ret[0] = a[0];
    ret[1] = a[1];
    ret[2] = a[2];
    ret[3] = a[3];

    ret[4] = -a[4];
    ret[5] = -a[5];
    ret[6] = -a[6];
    ret[7] = -a[7];

    return ret;
}

getDual :: (a:Fl) -> Fl{

    ret:Fl;
    ret[0] = a[7];
    ret[1] = a[6];
    ret[2] = a[5];
    ret[3] = a[4];

    ret[4] = -a[3];
    ret[5] = -a[2];
    ret[6] = -a[1];
    ret[7] = -a[0];

    return ret;
}

joinPt :: (a:Fl, b:Fl) -> Dq {

    ret:Dq;
	ret[7] = 0.;
    
    ret[6] = + a[6] * b[7] - a[7] * b[6];
    ret[5] = + a[5] * b[7] - a[7] * b[5];
    ret[4] = + a[4] * b[7] - a[7] * b[4];
    ret[3] = + a[5] * b[6] - a[6] * b[5];
    ret[2] = - a[4] * b[6] + a[6] * b[4];
    ret[1] = + a[4] * b[5] - a[5] * b[4];
    
    ret[0] = + a[0] * b[7] + a[1] * b[6] + a[2] * b[5] - a[3] * b[4];

    return ret;
}

//DQ functions
operator * :: (a:Dq, b:Dq) -> Dq {

    ret:Dq;
	ret[0] = + b[0] * a[0] - b[4] * a[4] - b[5] * a[5] - b[6] * a[6];

    ret[1] = + b[1] * a[0] + b[0] * a[1] - b[4] * a[2] + b[5] * a[3] + b[2] * a[4] - b[3] * a[5] - b[7] * a[6] - b[6] * a[7];
    ret[2] = + b[2] * a[0] + b[4] * a[1] + b[0] * a[2] - b[6] * a[3] - b[1] * a[4] - b[7] * a[5] + b[3] * a[6] - b[5] * a[7];
    ret[3] = + b[3] * a[0] - b[5] * a[1] + b[6] * a[2] + b[0] * a[3] - b[7] * a[4] + b[1] * a[5] - b[2] * a[6] - b[4] * a[7];
    ret[4] = + b[4] * a[0] + b[0] * a[4] + b[6] * a[5] - b[5] * a[6];
    ret[5] = + b[5] * a[0] - b[6] * a[4] + b[0] * a[5] + b[4] * a[6];
    ret[6] = + b[6] * a[0] + b[5] * a[4] - b[4] * a[5] + b[0] * a[6];

    ret[7] = + b[7] * a[0] + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] + b[3] * a[4] + b[2] * a[5] + b[1] * a[6] + b[0] * a[7];

    return ret;
}

operator + :: (a:Dq, b:Dq) -> Dq
{
    ret:Dq;

    //the identity part, eg the part of this transform that is like a 0-degree rotation
    ret[0] = a[0] + b[0];

    //the line part, eg the part of this transform that is like a 180-degree rotation
    ret[1] = a[1] + b[1]; ret[2] = a[2] + b[2]; ret[3] = a[3] + b[3]; ret[4] = a[4] + b[4]; ret[5] = a[5] + b[5]; ret[6] = a[6] + b[6];

    //the screwiness part - if you take a 180 rotation and set this part equal to d
    //it will now be a 180 screw, with d as the distance
    ret[7] = a[7] + b[7];

    return ret;
}

meet :: (a:Dq, b:Dq) -> Dq{

    ret:Dq;
	ret[0] = + b[0] * a[0];

    ret[1] = + b[1] * a[0] + b[0] * a[1];
    ret[2] = + b[2] * a[0] + b[0] * a[2];
    ret[3] = + b[3] * a[0] + b[0] * a[3];
    ret[4] = + b[4] * a[0] + b[0] * a[4];
    ret[5] = + b[5] * a[0] + b[0] * a[5];
    ret[6] = + b[6] * a[0] + b[0] * a[6];

    ret[7] = + b[7] * a[0] + b[6] * a[1] + b[5] * a[2] + b[4] * a[3] + b[3] * a[4] + b[2] * a[5] + b[1] * a[6] + b[0] * a[7];

    return ret;
}

inner :: (a:Dq, b:Dq) -> Dq {

    ret:Dq;
	ret[0] = + b[0] * a[0] - b[4] * a[4] - b[5] * a[5] - b[6] * a[6];

    ret[1] = + b[1] * a[0] + b[0] * a[1] - b[7] * a[6] - b[6] * a[7];
    ret[2] = + b[2] * a[0] + b[0] * a[2] - b[7] * a[5] - b[5] * a[7];
    ret[3] = + b[3] * a[0] + b[0] * a[3] - b[7] * a[4] - b[4] * a[7];
    ret[4] = + b[4] * a[0] + b[0] * a[4];
    ret[5] = + b[5] * a[0] + b[0] * a[5];
    ret[6] = + b[6] * a[0] + b[0] * a[6];

    ret[7] = + b[7] * a[0] + b[0] * a[7];

    return ret;
}

mul :: (a:Dq, b:Fl) -> Fl {

    ret : Fl;
	ret[0] = + b[0] * a[0] + b[1] * a[1] + b[2] * a[2] + b[3] * a[3] + b[4] * a[4] + b[5] * a[5] + b[6] * a[6] - b[7] * a[7];
    ret[1] = + b[1] * a[0] + b[2] * a[4] - b[3] * a[5] - b[7] * a[6];
    ret[2] = + b[2] * a[0] - b[1] * a[4] - b[7] * a[5] + b[3] * a[6];
    ret[3] = + b[3] * a[0] - b[7] * a[4] + b[1] * a[5] - b[2] * a[6];

    ret[4] = + b[4] * a[0] - b[2] * a[1] + b[1] * a[2] - b[7] * a[3] - b[0] * a[4] + b[6] * a[5] - b[5] * a[6] - b[3] * a[7];
    ret[5] = + b[5] * a[0] + b[3] * a[1] - b[7] * a[2] - b[1] * a[3] - b[6] * a[4] - b[0] * a[5] + b[4] * a[6] - b[2] * a[7];
    ret[6] = + b[6] * a[0] - b[7] * a[1] - b[3] * a[2] + b[2] * a[3] + b[5] * a[4] - b[4] * a[5] - b[0] * a[6] - b[1] * a[7];
    ret[7] = + b[7] * a[0] + b[3] * a[4] + b[2] * a[5] + b[1] * a[6];

    return ret;
}

meet :: (a:Dq, b:Fl) -> Fl {

    ret:Fl;
	ret[0] = + b[0] * a[0];
    ret[1] = + b[1] * a[0];
    ret[2] = + b[2] * a[0];
    ret[3] = + b[3] * a[0];

    ret[4] = + b[4] * a[0] - b[2] * a[1] + b[1] * a[2] - b[0] * a[4];
    ret[5] = + b[5] * a[0] + b[3] * a[1] - b[1] * a[3] - b[0] * a[5];
    ret[6] = + b[6] * a[0] - b[3] * a[2] + b[2] * a[3] - b[0] * a[6];
    ret[7] = + b[7] * a[0] + b[3] * a[4] + b[2] * a[5] + b[1] * a[6];

    return ret;
}

inner :: (a:Dq, b:Fl) -> Fl{

    ret:Fl;
	ret[0] = + b[0] * a[0] + b[1] * a[1] + b[2] * a[2] + b[3] * a[3] + b[4] * a[4] + b[5] * a[5] + b[6] * a[6] - b[7] * a[7];
    ret[1] = + b[1] * a[0] + b[2] * a[4] - b[3] * a[5] - b[7] * a[6];
    ret[2] = + b[2] * a[0] - b[1] * a[4] - b[7] * a[5] + b[3] * a[6];
    ret[3] = + b[3] * a[0] - b[7] * a[4] + b[1] * a[5] - b[2] * a[6];
    
    ret[4] = + b[4] * a[0] - b[3] * a[7];
    ret[5] = + b[5] * a[0] - b[2] * a[7];
    ret[6] = + b[6] * a[0] - b[1] * a[7];
    ret[7] = + b[7] * a[0];

    return ret;
}

getReverse :: (a:Dq) -> Dq {

    ret:Dq;
	ret[0] =  a[0];

	ret[1] = -a[1];
	ret[2] = -a[2];
	ret[3] = -a[3];
	ret[4] = -a[4];
	ret[5] = -a[5];
	ret[6] = -a[6];

	ret[7] = a[7];

    return ret;
}

getDual :: (a:Dq) -> Dq {

    ret:Dq;
	ret[0] = a[7];
	
	ret[1] = a[6];
	ret[2] = a[5];
	ret[3] = a[4];
	ret[4] = a[3];
	ret[5] = a[2];
	ret[6] = a[1];

	ret[7] = a[0];

    return ret;
}

joinPt :: (a:Dq, b:Fl) -> Fl {

    ret:Fl;
    ret[0] = + a[1] * b[6] + a[2] * b[5] + a[3] * b[4];
    ret[1] = - a[1] * b[7] + a[4] * b[5] - a[5] * b[4];
    ret[2] = - a[2] * b[7] - a[4] * b[6] + a[6] * b[4];
	ret[3] = - a[3] * b[7] + a[5] * b[6] - a[6] * b[5];
    
    //join a 180 screw with a point and get... a rotoreflection?
    ret[4] = 0.; // - a[7] * b[4];
    ret[5] = 0.; // - a[7] * b[5];
    ret[6] = 0.; // - a[7] * b[6];
	ret[7] = 0.; // - a[7] * b[7];

    return ret;
}
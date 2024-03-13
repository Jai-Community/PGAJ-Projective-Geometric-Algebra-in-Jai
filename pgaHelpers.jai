

make_translator :: ( x: float = 0., y : float = 0., z : float=0.)->Dq {
    
    ret:=oneDq;

    ret[1] = -.5 * x;
    ret[2] = -.5 * y;
    ret[3] = -.5 * z;

    return ret;
}
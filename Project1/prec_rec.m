function [p,r] = prec_rec(groundtruth, prediction)
    tp = sum(prediction == groundtruth & prediction == 1);
    fp = sum(prediction ~= groundtruth & prediction == 1);
    tn = sum(prediction == groundtruth & prediction == 0);
    fn = sum(prediction ~= groundtruth & prediction == 0);
    
    p = tp / (tp + fp);
    r = tp / (tp + fn);
end
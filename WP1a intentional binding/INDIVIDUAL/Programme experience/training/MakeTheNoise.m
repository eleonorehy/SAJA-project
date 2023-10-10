function z = MakeTheNoise(lowNoise, highNoise)

mu = [lowNoise highNoise];
sigma = [1 0.5; 0.5 2];
R = chol(sigma);
z = repmat(mu,1,1) + randn(1,2)*R;
end

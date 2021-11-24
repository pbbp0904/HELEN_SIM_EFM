A = zeros(4,3);
E = zeros(4,3);

xind = randi(length(x),1,4);
zind = randi(length(z),1,4);

A(:,1) = x(xind)';
A(:,2) = zeros(4,1);
A(:,3) = z(zind)';

for payload = 1:4
    E(payload,1) = E_x(zind(payload),xind(payload));
    E(payload,2) = E_y(zind(payload),xind(payload));
    E(payload,3) = E_z(zind(payload),xind(payload));
end

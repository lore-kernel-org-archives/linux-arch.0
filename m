From: Austin S Hemmelgarn <ahferroin7@gmail.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Wed, 4 Nov 2015 08:22:59 -0500
Message-ID: <563A06B3.3050106@gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
 <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
 <20151103224545.GI29330@redhat.com>
 <CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms070206040103040303070908"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35964 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbKDNXH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2015 08:23:07 -0500
In-Reply-To: <CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, thehajime@gmail.com

This is a cryptographically signed message in MIME format.

--------------ms070206040103040303070908
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2015-11-03 18:24, Octavian Purdila wrote:
> On Wed, Nov 4, 2015 at 12:45 AM, Richard W.M. Jones <rjones@redhat.com>=
 wrote:
>> I'm dubious that a lib-based approach could support LVM, partioning,
>> ntfs-3g, qcow2, vmdk and all the other libguestfs stuff that relies on=

>> userspace tools + qemu as well as just the kernel drivers.
>> Nevertheless a fast subset of libguestfs supporting just kernel
>> filesystem drivers could be useful.
>
> LKL uses the full Linux I/O stack and I think LVM and partitioning
> should work out of the box. Adding support for qcow2 and vmdk should
> be possible as well. ntfs-3g might be problematic.

Partitioning will work fine based on what you say.  MD using the old=20
metadata and automatic assembly should also work fine (assuming there is =

some way to tell the library to simulate running initcalls).  DM (and by =

extension LVM, which is a bunch of userspace stuff on top of regular DM) =

and new style MD both require userspace tools to configure and interact=20
with, this could be handled in two different ways:
1. Update the LVM and MD tools so they can be built as libraries and
    work directly with LKL.
2. Provide some wrapper functions to emulate dmsetup, lvm, and mdadm as
    distinct library calls.
Of these, the first option is likely to be the best for long-term=20
support, but the second is probably going to be easier to code quickly.

QCOW2 and VMDK are both VM disk formats, and while I would love to see a =

driver treat them (and VDI, and VHD) like regular disk images on Linux=20
in general, that will take some effort to implement properly.

NTFS-3G is a FUSE based filesystem driver, so that kind of functionality =

would probably need to be implemented in the application itself=20
(although having some way to have the app just link to it instead would=20
be absolutely wonderful).



--------------ms070206040103040303070908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
Brgwgga0MIIEnKADAgECAgMRLfgwDQYJKoZIhvcNAQENBQAweTEQMA4GA1UEChMHUm9vdCBD
QTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNp
Z25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcwHhcN
MTUwOTIxMTEzNTEzWhcNMTYwMzE5MTEzNTEzWjBjMRgwFgYDVQQDEw9DQWNlcnQgV29UIFVz
ZXIxIzAhBgkqhkiG9w0BCQEWFGFoZmVycm9pbjdAZ21haWwuY29tMSIwIAYJKoZIhvcNAQkB
FhNhaGVtbWVsZ0BvaGlvZ3QuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
nQ/81tq0QBQi5w316VsVNfjg6kVVIMx760TuwA1MUaNQgQ3NyUl+UyFtjhpkNwwChjgAqfGd
LIMTHAdObcwGfzO5uI2o1a8MHVQna8FRsU3QGouysIOGQlX8jFYXMKPEdnlt0GoQcd+BtESr
pivbGWUEkPs1CwM6WOrs+09bAJP3qzKIr0VxervFrzrC5Dg9Rf18r9WXHElBuWHg4GYHNJ2V
Ab8iKc10h44FnqxZK8RDN8ts/xX93i9bIBmHnFfyNRfiOUtNVeynJbf6kVtdHP+CRBkXCNRZ
qyQT7gbTGD24P92PS2UTmDfplSBcWcTn65o3xWfesbf02jF6PL3BCrVnDRI4RgYxG3zFBJuG
qvMoEODLhHKSXPAyQhwZINigZNdw5G1NqjXqUw+lIqdQvoPijK9J3eijiakh9u2bjWOMaleI
SMRR6XsdM2O5qun1dqOrCgRkM0XSNtBQ2JjY7CycIx+qifJWsRaYWZz0aQU4ZrtAI7gVhO9h
pyNaAGjvm7PdjEBiXq57e4QcgpwzvNlv8pG1c/hnt0msfDWNJtl3b6elhQ2Pz4w/QnWifZ8E
BrFEmjeeJa2dqjE3giPVWrsH+lOvQQONsYJOuVb8b0zao4vrWeGmW2q2e3pdv0Axzm/60cJQ
haZUv8+JdX9ZzqxOm5w5eUQSclt84u+D+hsCAwEAAaOCAVkwggFVMAwGA1UdEwEB/wQCMAAw
VgYJYIZIAYb4QgENBEkWR1RvIGdldCB5b3VyIG93biBjZXJ0aWZpY2F0ZSBmb3IgRlJFRSBo
ZWFkIG92ZXIgdG8gaHR0cDovL3d3dy5DQWNlcnQub3JnMA4GA1UdDwEB/wQEAwIDqDBABgNV
HSUEOTA3BggrBgEFBQcDBAYIKwYBBQUHAwIGCisGAQQBgjcKAwQGCisGAQQBgjcKAwMGCWCG
SAGG+EIEATAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2Vy
dC5vcmcwMQYDVR0fBCowKDAmoCSgIoYgaHR0cDovL2NybC5jYWNlcnQub3JnL3Jldm9rZS5j
cmwwNAYDVR0RBC0wK4EUYWhmZXJyb2luN0BnbWFpbC5jb22BE2FoZW1tZWxnQG9oaW9ndC5j
b20wDQYJKoZIhvcNAQENBQADggIBADMnxtSLiIunh/TQcjnRdf63yf2D8jMtYUm4yDoCF++J
jCXbPQBGrpCEHztlNSGIkF3PH7ohKZvlqF4XePWxpY9dkr/pNyCF1PRkwxUURqvuHXbu8Lwn
8D3U2HeOEU3KmrfEo65DcbanJCMTTW7+mU9lZICPP7ZA9/zB+L0Gm1UNFZ6AU50N/86vjQfY
WgkCd6dZD4rQ5y8L+d/lRbJW7ZGEQw1bSFVTRpkxxDTOwXH4/GpQfnfqTAtQuJ1CsKT12e+H
NSD/RUWGTr289dA3P4nunBlz7qfvKamxPymHeBEUcuICKkL9/OZrnuYnGROFwcdvfjGE5iLB
kjp/ttrY4aaVW5EsLASNgiRmA6mbgEAMlw3RwVx0sVelbiIAJg9Twzk4Ct6U9uBKiJ8S0sS2
8RCSyTmCRhJs0vvva5W9QUFGmp5kyFQEoSfBRJlbZfGX2ehI2Hi3U2/PMUm2ONuQG1E+a0AP
u7I0NJc/Xil7rqR0gdbfkbWp0a+8dAvaM6J00aIcNo+HkcQkUgtfrw+C2Oyl3q8IjivGXZqT
5UdGUb2KujLjqjG91Dun3/RJ/qgQlotH7WkVBs7YJVTCxfkdN36rToPcnMYOI30FWa0Q06gn
F6gUv9/mo6riv3A5bem/BdbgaJoPnWQD9D8wSyci9G4LKC+HQAMdLmGoeZfpJzKHMYIE0TCC
BM0CAQEwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNl
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DANBglghkgBZQMEAgMFAKCCAiEwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTUxMTA0MTMyMjU5WjBPBgkq
hkiG9w0BCQQxQgRAkW+jt5qtVmw8zKTg6Iuyghh7rRFu6MJFmwv27WtFhniJXOi9+0oVJqSv
iq3iaJQrnh4itR+9E33oQ7X05kenATBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAxEt+DCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMHUm9vdCBDQTEe
MBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25p
bmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAxEt+DAN
BgkqhkiG9w0BAQEFAASCAgCWckdPTuOgw2tXT6JZSXNH/tdnIT1ha16YIM2FVsJvAsMnDXsy
LKLSsoPoxpCq1kNGxq3bQrYJ1WBh0l8a2bffcNeH7NWetrZWqsi2QmmXOhQbto4xaV1rxwis
H3stnhwIDcl9wOgxedzY04rIPb989O2Xb9XSlArmA1ccDpjyKLedHmFVA+SKF5vFPCmiXWp9
Kp3LqLCgJ9pqmP3FTE8gxGXpl2vjckikQZ3lOS6NaSLl3ZJNzx/PQvZKp5DkOF5cNukySICH
pYz460qBOP9A2iUIAssJyx+O/cXttFFDTzC7+J7RQo62Wl5e6lKdIjhvwpwEP/8ifrcsYkYM
pSj81cv78aGAF1IyDYj4kTiLKxIwVIK+seqJl/phkaPmmLBMhqqUIVNW1p3+oX6TgJHGTwiV
xvW3elwp59DallbXuFpd3BCJF/+95q7DUYns5GT0pPAwpUDm6J3ipVnocGVorr93o+rcO33Y
3C7Smfv0P43YipvI16GY2D9RRvKMxPWieiu0cslyLf13blv3/fy6jXRqK58dq/r9vUnjLIFg
dNOmcayP9qtKdGVCoINPrExE+JkzKw7JEqgefm/pWczBcCQI2sQvBvEygW8qDHvGzkYY80ti
AP78RK1Bo7s6cxZBjzu3EoFH+LMjIXOSJKeebfrND+/pqv1IMTDr0iyybQAAAAAAAA==
--------------ms070206040103040303070908--

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Wed, 8 Jan 2020 09:44:36 +0100
Message-ID: <CAK8P3a21yPrmp4ik3Ei1BZfeqZNf0wL5NZNF3uXqb4FLRDyUPw@mail.gmail.com>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
 <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, ML nouveau <nouveau@lists.freedesktop.org>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCBKYW4gOCwgMjAyMCBhdCA5OjM2IEFNIENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9w
aGUubGVyb3lAYy1zLmZyPiB3cm90ZToKPiBMZSAwOC8wMS8yMDIwIMOgIDA5OjE4LCBLcnp5c3p0
b2YgS296bG93c2tpIGEgw6ljcml0IDoKPiA+IE9uIFdlZCwgOCBKYW4gMjAyMCBhdCAwOToxMywg
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6Cj4gPiBJJ2xs
IGFkZCB0byB0aGlzIG9uZSBhbHNvIGNoYW5nZXMgdG8gaW9yZWFkWF9yZXAoKSBhbmQgYWRkIGFu
b3RoZXIKPiA+IHBhdGNoIGZvciB2b2xhdGlsZSBmb3IgcmVhZHMgYW5kIHdyaXRlcy4gSSBndWVz
cyB5b3VyIHJldmlldyB3aWxsIGJlCj4gPiBhcHByZWNpYXRlZCBvbmNlIG1vcmUgYmVjYXVzZSBv
ZiBpb3JlYWRYX3JlcCgpCj4gPgo+Cj4gdm9sYXRpbGUgc2hvdWxkIHJlYWxseSBvbmx5IGJlIHVz
ZWQgd2hlcmUgZGVlbWVkIG5lY2Vzc2FyeToKPgo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9j
L2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvdm9sYXRpbGUtY29uc2lkZXJlZC1oYXJtZnVsLmh0bWwKPgo+
IEl0IGlzIHNhaWQ6ICIgLi4uICBhY2Nlc3NvciBmdW5jdGlvbnMgbWlnaHQgdXNlIHZvbGF0aWxl
IG9uCj4gYXJjaGl0ZWN0dXJlcyB3aGVyZSBkaXJlY3QgSS9PIG1lbW9yeSBhY2Nlc3MgZG9lcyB3
b3JrLiBFc3NlbnRpYWxseSwKPiBlYWNoIGFjY2Vzc29yIGNhbGwgYmVjb21lcyBhIGxpdHRsZSBj
cml0aWNhbCBzZWN0aW9uIG9uIGl0cyBvd24gYW5kCj4gZW5zdXJlcyB0aGF0IHRoZSBhY2Nlc3Mg
aGFwcGVucyBhcyBleHBlY3RlZCBieSB0aGUgcHJvZ3JhbW1lci4iCgpUaGUgSS9PIGFjY2Vzc29y
cyBhcmUgb25lIG9mIHRoZSBmZXcgcGxhY2VzIGluIHdoaWNoICd2b2xhdGlsZScgZ2VuZXJhbGx5
Cm1ha2VzIHNlbnNlLCBhdCBsZWFzdCBmb3IgdGhlIGltcGxlbWVudGF0aW9ucyB0aGF0IGRvIGEg
cGxhaW4gcG9pbnRlcgpkZXJlZmVyZW5jZSAocHJvYmFibHkgbm9uZSBvZiB0aGUgb25lcyBpbiBx
dWVzdGlvbiBoZXJlKS4KCkluIGNhc2Ugb2YgcmVhZGwvd3JpdGVsLCB0aGlzIGlzIHdoYXQgd2Ug
ZG8gaW4gYXNtLWdlbmVyaWM6CgpzdGF0aWMgaW5saW5lIHUzMiBfX3Jhd19yZWFkbChjb25zdCB2
b2xhdGlsZSB2b2lkIF9faW9tZW0gKmFkZHIpCnsKICAgICAgICByZXR1cm4gKihjb25zdCB2b2xh
dGlsZSB1MzIgX19mb3JjZSAqKWFkZHI7Cn0KClRoZSBfX2ZvcmNlLWNhc3QgdGhhdCByZW1vdmVz
IHRoZSBfX2lvbWVtIGhlcmUgYWxzbyBtZWFucyB0aGF0CnRoZSAndm9sYXRpbGUnIGtleXdvcmQg
Y291bGQgYmUgZHJvcHBlZCBmcm9tIHRoZSBhcmd1bWVudCBsaXN0LAphcyBpdCBoYXMgbm8gcmVh
bCBlZmZlY3QgYW55IG1vcmUsIGJ1dCB0aGVuIHRoZXJlIGFyZSBhIGZldyBkcml2ZXJzCnRoYXQg
bWFyayB0aGVpciBpb21lbSBwb2ludGVycyBhcyBlaXRoZXIgJ3ZvbGF0aWxlIHZvaWQgX19pb21l
bSonIG9yCih3b3JzZSkgJ3ZvbGF0aWxlIHZvaWQgKicsIHNvIHdlIGtlZXAgaXQgaW4gdGhlIGFy
Z3VtZW50IGxpc3QgdG8gbm90CmFkZCB3YXJuaW5ncyBmb3IgdGhvc2UgZHJpdmVycy4KCkl0IG1h
eSBiZSB0aW1lIHRvIGNoYW5nZSB0aGVzZSBkcml2ZXJzIHRvIG5vdCB1c2Ugdm9sYXRpbGUgZm9y
IF9faW9tZW0KcG9pbnRlcnMsIGJ1dCB0aGF0IHNlZW1zIG91dCBvZiBzY29wZSBmb3Igd2hhdCBL
cnp5c3p0b2YgaXMgdHJ5aW5nCnRvIGRvLiBJZGVhbGx5IHdlIHdvdWxkIGJlIGNvbnNpc3RlbnQg
aGVyZSB0aG91Z2gsIGVpdGhlciB1c2luZyB2b2xhdGlsZQphbGwgdGhlIHRpbWUgb3IgbmV2ZXIu
CgogICAgICAgIEFybmQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==

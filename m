From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RESEND PATCH v2 9/9] ath5k: Constify ioreadX() iomem argument
 (as in generic implementation)
Date: Mon, 24 Feb 2020 14:00:06 +0000
Message-ID: <ef12bfd658504d928996681f8a9ee96f@AcuMS.aculab.com>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-10-krzk@kernel.org>
 <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com> <20200224124744.GA1949@pi3>
 <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: 'Geert Uytterhoeven' <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjAgMTI6NTQN
Cj4gVG86IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCi4uLg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVrL2FoYi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVrL2FoYi5jDQo+ID4gPiA+IGluZGV4IDJjOWNlYzhi
NTNkOS4uOGJkMDFkZjM2OWZiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9hdGgvYXRoNWsvYWhiLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YXRoL2F0aDVrL2FoYi5jDQo+ID4gPiA+IEBAIC0xMzgsMTggKzEzOCwxOCBAQCBzdGF0aWMgaW50
IGF0aF9haGJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4NCj4g
PiA+ID4gICAgIGlmIChiY2ZnLT5kZXZpZCA+PSBBUjVLX1NSRVZfQVIyMzE1X1I2KSB7DQo+ID4g
PiA+ICAgICAgICAgICAgIC8qIEVuYWJsZSBXTUFDIEFIQiBhcmJpdHJhdGlvbiAqLw0KPiA+ID4g
PiAtICAgICAgICAgICByZWcgPSBpb3JlYWQzMigodm9pZCBfX2lvbWVtICopIEFSNUtfQVIyMzE1
X0FIQl9BUkJfQ1RMKTsNCj4gPiA+ID4gKyAgICAgICAgICAgcmVnID0gaW9yZWFkMzIoKGNvbnN0
IHZvaWQgX19pb21lbSAqKSBBUjVLX0FSMjMxNV9BSEJfQVJCX0NUTCk7DQo+ID4gPg0KPiA+ID4g
V2hpbGUgSSB1bmRlcnN0YW5kIHdoeSB0aGUgcGFyYW1ldGVyIG9mIGlvcmVhZDMyIHNob3VsZCBi
ZSBjb25zdCwgSQ0KPiA+ID4gZG9uJ3Qgc2VlIGEgcmVhc29uIGZvciB0aGVzZSBjYXN0cyBvbiB0
aGUgdXNlcnMnIHNpZGUuIFdoYXQgZG9lcyBpdA0KPiA+ID4gYnJpbmcgZXhjZXB0IGxvbmdlciBj
b2RlIHRvIHJlYWQ/DQo+ID4NCj4gPiBCZWNhdXNlIHRoZSBhcmd1bWVudCBpcyBhbiBpbnQ6DQo+
ID4NCj4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoNWsvYWhiLmM6IEluIGZ1bmN0aW9u
IOKAmGF0aF9haGJfcHJvYmXigJk6DQo+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVr
L2FoYi5jOjE0MToxODogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAxIG9mIOKAmGlvcmVhZDMy
4oCZIG1ha2VzIHBvaW50ZXINCj4gZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2ludC1j
b252ZXJzaW9uXQ0KPiA+ICAgIHJlZyA9IGlvcmVhZDMyKEFSNUtfQVIyMzE1X0FIQl9BUkJfQ1RM
KTsNCj4gDQo+IFRoYXQncyBhbiBhcmd1bWVudCBmb3Iga2VlcGluZyB0aGUgY2FzdCB0byAidm9p
ZCBfX2lvbWVtICoiLCBub3QgZm9yDQo+IGFkZGluZyB0aGUgImNvbnN0IiwgcmlnaHQ/DQoNCk9y
IG1vcmUgbGlrZWx5IGNoYW5nZSB0aGUgZGVmaW5pdGlvbnMgdG8gdXNlIGEgc3RydWN0IGZvciB0
aGUgbGF5b3V0Lg0KVGhhdCBhbHNvIHN0b3BzIHRoZSBjb25zdGFudHMgYmVpbmcgdXNlZCBpbiB0
aGUgd3JvbmcgcGxhY2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

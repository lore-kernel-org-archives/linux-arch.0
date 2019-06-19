From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Date: Wed, 19 Jun 2019 11:05:57 +0200
Message-ID: <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Farhan Ali <alifm@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, dri-devel <dri-devel@lists.freedesktop.org>, Jaroslav Kysela <perex@perex.cz>, Evgeniy Polyakov <zbr@ioremap.net>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby <jslaby@suse.com>, Guenter Roeck <linux@roeck-us.net>, Ohad Ben-Cohen <ohad@wizery.com>, Marc Zyngier <marc.zyngier@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>l
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBKdW4gMTgsIDIwMTkgYXQgMTA6NTUgUE0gTWF1cm8gQ2FydmFsaG8gQ2hlaGFiCjxt
Y2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz4gd3JvdGU6Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZ3B1L2RybS1tbS5yc3QgYi9Eb2N1bWVudGF0aW9uL2dwdS9kcm0tbW0ucnN0Cj4gaW5k
ZXggZmEzMGRmY2ZjM2M4Li5iMGY5NDhkODczM2IgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9ncHUvZHJtLW1tLnJzdAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZ3B1L2RybS1tbS5yc3QKPiBA
QCAtMzIwLDcgKzMyMCw3IEBAIHN0cnVjdCA6Yzp0eXBlOmBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25z
IDxmaWxlX29wZXJhdGlvbnM+YCBnZXRfdW5tYXBwZWRfYXJlYQo+ICBmaWVsZCB3aXRoIGEgcG9p
bnRlciBvbiA6YzpmdW5jOmBkcm1fZ2VtX2NtYV9nZXRfdW5tYXBwZWRfYXJlYWAuCj4KPiAgTW9y
ZSBkZXRhaWxlZCBpbmZvcm1hdGlvbiBhYm91dCBnZXRfdW5tYXBwZWRfYXJlYSBjYW4gYmUgZm91
bmQgaW4KPiAtRG9jdW1lbnRhdGlvbi9ub21tdS1tbWFwLnJzdAo+ICtEb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvbm9tbXUtbW1hcC5yc3QKClJhbmRvbSBkcml2ZS1ieSBjb21tZW50OiBDb3VsZCB3
ZSBjb252ZXJ0IHRoZXNlIGludG8gaHlwZXJsaW5rcyB3aXRoaW4Kc3BoaW54IHNvbWVob3csIHdp
dGhvdXQgbWFraW5nIHRoZW0gbGVzcyB1c2VmdWwgYXMgcmF3IGZpbGUgcmVmZXJlbmNlcwood2l0
aCB2aW0gSSBjYW4ganVzdCB0eXBlICdnZicgYW5kIGl0IHdvcmtzLCBlbWFjcyBwcm9iYWJseSB0
aGUgc2FtZSkuCi1EYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIElu
dGVsIENvcnBvcmF0aW9uCis0MSAoMCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwu
Y2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

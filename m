From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Date: Wed, 19 Jun 2019 12:42:39 +0200
Message-ID: <20190619104239.GM3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
 <CAKMK7uGM1aZz9yg1kYM8w2gw_cS6Eaynmar-uVurXjK5t6WouQ@mail.gmail.com>
 <20190619072218.4437f891@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190619072218.4437f891@coco.lan>
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

T24gV2VkLCBKdW4gMTksIDIwMTkgYXQgMDc6MjI6MThBTSAtMDMwMCwgTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIHdyb3RlOgo+IEhpIERhbmllbCwKPiAKPiBFbSBXZWQsIDE5IEp1biAyMDE5IDExOjA1
OjU3ICswMjAwCj4gRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPiBlc2NyZXZldToKPiAK
PiA+IE9uIFR1ZSwgSnVuIDE4LCAyMDE5IGF0IDEwOjU1IFBNIE1hdXJvIENhcnZhbGhvIENoZWhh
Ygo+ID4gPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZ3B1L2RybS1tbS5yc3QgYi9Eb2N1bWVudGF0aW9uL2dwdS9kcm0t
bW0ucnN0Cj4gPiA+IGluZGV4IGZhMzBkZmNmYzNjOC4uYjBmOTQ4ZDg3MzNiIDEwMDY0NAo+ID4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2dwdS9kcm0tbW0ucnN0Cj4gPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZ3B1L2RybS1tbS5yc3QKPiA+ID4gQEAgLTMyMCw3ICszMjAsNyBAQCBzdHJ1Y3QgOmM6
dHlwZTpgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyA8ZmlsZV9vcGVyYXRpb25zPmAgZ2V0X3VubWFw
cGVkX2FyZWEKPiA+ID4gIGZpZWxkIHdpdGggYSBwb2ludGVyIG9uIDpjOmZ1bmM6YGRybV9nZW1f
Y21hX2dldF91bm1hcHBlZF9hcmVhYC4KPiA+ID4KPiA+ID4gIE1vcmUgZGV0YWlsZWQgaW5mb3Jt
YXRpb24gYWJvdXQgZ2V0X3VubWFwcGVkX2FyZWEgY2FuIGJlIGZvdW5kIGluCj4gPiA+IC1Eb2N1
bWVudGF0aW9uL25vbW11LW1tYXAucnN0Cj4gPiA+ICtEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkv
bm9tbXUtbW1hcC5yc3QgIAo+ID4gCj4gPiBSYW5kb20gZHJpdmUtYnkgY29tbWVudDogQ291bGQg
d2UgY29udmVydCB0aGVzZSBpbnRvIGh5cGVybGlua3Mgd2l0aGluCj4gPiBzcGhpbnggc29tZWhv
dywgd2l0aG91dCBtYWtpbmcgdGhlbSBsZXNzIHVzZWZ1bCBhcyByYXcgZmlsZSByZWZlcmVuY2Vz
Cj4gPiAod2l0aCB2aW0gSSBjYW4ganVzdCB0eXBlICdnZicgYW5kIGl0IHdvcmtzLCBlbWFjcyBw
cm9iYWJseSB0aGUgc2FtZSkuCj4gPiAtRGFuaWVsCj4gCj4gU2hvcnQgYW5zd2VyOiBJIGRvbid0
IGtub3cgaG93IHZpbS9lbWFjcyB3b3VsZCByZWNvZ25pemUgU3BoaW54IHRhZ3MuCgpObywgdGhl
IG90aGVyIHdheSBhcm91bmQsIFNwaGlueCBjYW4gcmVjb2duaXplIGxvY2FsIGZpbGVzIGFuZCB0
cmVhdAp0aGVtIHNwZWNpYWwuIFRoYXQgd2F5IHdlIGtlZXAgdGhlIHRleHQgcmVhZGFibGUuCgpT
YW1lIHdpdGggdGhhdCA6YzpmdW5jOidmb28nIGNyYXAsIHRoYXQgbmVlZHMgdG8gZGllLCBhbmQg
U3BoaW54IG5lZWRzCnRvIGJlIHRhdWdodCBhYm91dCBmb28oKS4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

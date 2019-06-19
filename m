From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Date: Wed, 19 Jun 2019 13:43:56 +0200
Message-ID: <20190619114356.GP3419@hirez.programming.kicks-ass.net>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
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
Cc: kernel-hardening@lists.openwall.com, Farhan Ali <alifm@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Evgeniy Polyakov <zbr@ioremap.net>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby <jslaby@suse.com>, Guenter Roeck <linux@roeck-us.net>, Ohad Ben-Cohen <ohad@wizery.com>, Marc Zyngier <marc.zyngier@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger>
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBKdW4gMTgsIDIwMTkgYXQgMDU6NTM6MTdQTSAtMDMwMCwgTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIHdyb3RlOgoKPiAgLi4uL3sgPT4gZHJpdmVyLWFwaX0vYXRvbWljX2JpdG9wcy5yc3Qg
ICAgICAgIHwgIDIgLQoKVGhhdCdzIGEgLnR4dCBmaWxlLCBiaWcgZmF0IE5BSyBmb3IgbWFraW5n
IGl0IGFuIHJzdC4KCj4gIC4uLi97ID0+IGRyaXZlci1hcGl9L2Z1dGV4LXJlcXVldWUtcGkucnN0
ICAgICB8ICAyIC0KCj4gIC4uLi97ID0+IGRyaXZlci1hcGl9L2djYy1wbHVnaW5zLnJzdCAgICAg
ICAgICB8ICAyIC0KCj4gIERvY3VtZW50YXRpb24veyA9PiBkcml2ZXItYXBpfS9rcHJvYmVzLnJz
dCAgICB8ICAyIC0KPiAgLi4uL3sgPT4gZHJpdmVyLWFwaX0vcGVyY3B1LXJ3LXNlbWFwaG9yZS5y
c3QgIHwgIDIgLQoKTW9yZSBOQUsgZm9yIHJzdCBjb252ZXJzaW9uCgo+ICBEb2N1bWVudGF0aW9u
L3sgPT4gZHJpdmVyLWFwaX0vcGktZnV0ZXgucnN0ICAgfCAgMiAtCj4gIC4uLi97ID0+IGRyaXZl
ci1hcGl9L3ByZWVtcHQtbG9ja2luZy5yc3QgICAgICB8ICAyIC0KCj4gIERvY3VtZW50YXRpb24v
eyA9PiBkcml2ZXItYXBpfS9yYnRyZWUucnN0ICAgICB8ICAyIC0KCj4gIC4uLi97ID0+IGRyaXZl
ci1hcGl9L3JvYnVzdC1mdXRleC1BQkkucnN0ICAgICB8ICAyIC0KPiAgLi4uL3sgPT4gZHJpdmVy
LWFwaX0vcm9idXN0LWZ1dGV4ZXMucnN0ICAgICAgIHwgIDIgLQoKPiAgLi4uL3sgPT4gZHJpdmVy
LWFwaX0vc3BlY3VsYXRpb24ucnN0ICAgICAgICAgIHwgIDggKy0tCj4gIC4uLi97ID0+IGRyaXZl
ci1hcGl9L3N0YXRpYy1rZXlzLnJzdCAgICAgICAgICB8ICAyIC0KCj4gIC4uLi97ID0+IGRyaXZl
ci1hcGl9L3RoaXNfY3B1X29wcy5yc3QgICAgICAgICB8ICAyIC0KCj4gIERvY3VtZW50YXRpb24v
bG9ja2luZy9ydC1tdXRleC5yc3QgICAgICAgICAgICB8ICAyICstCgpOQUsuIE5vbmUgb2YgdGhl
IGFib3ZlIGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCBkcml2ZXItYXBpLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Sat, 25 Jan 2020 12:19:31 +0100
Message-ID: <20200125111931.GW11457@worktop.programming.kicks-ass.net>
References: <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, dave.dice@oracle.com, Jan Glauber <jglauber@marvell.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, Steven Sistare <steven.sistare@oracle.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBKYW4gMjQsIDIwMjAgYXQgMDE6MTk6MDVQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90
ZToKCj4gSXMgdGhlcmUgYSBsaWdodHdlaWdodCB3YXkgdG8gaWRlbnRpZnkgc3VjaCBhIOKAnHBy
aW9yaXRpemVk4oCdIHRocmVhZD8KCk5vOyBwZW9wbGUgbWlnaHQgZm9yIGluc3RhbmNlIGNhcmUg
YWJvdXQgdGFpbCBsYXRlbmNpZXMgYmV0d2VlbiB0aGVpcgppZGVudGljYWxseSBzcGVjJ2VkIHdv
cmtlciB0YXNrcy4KCkluIGdlbmVyYWwgaXQgdHVybnMgb3V0IHRoYXQgcHJpb3JpdHkgaXMgYSBk
eW5hbWljIGNvbmNlcHQsIG5vdCBhIHN0YXRpYwpvbmUuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

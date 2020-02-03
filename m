From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Mon, 3 Feb 2020 14:45:40 +0100
Message-ID: <20200203134540.GA14879@hirez.programming.kicks-ass.net>
References: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
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

T24gVGh1LCBKYW4gMzAsIDIwMjAgYXQgMDU6MDU6MjhQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90
ZToKPiAKPiA+IE9uIEphbiAyNSwgMjAyMCwgYXQgNjoxOSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+IAo+ID4gT24gRnJpLCBKYW4gMjQsIDIwMjAg
YXQgMDE6MTk6MDVQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90ZToKPiA+IAo+ID4+IElzIHRoZXJl
IGEgbGlnaHR3ZWlnaHQgd2F5IHRvIGlkZW50aWZ5IHN1Y2ggYSDigJxwcmlvcml0aXplZOKAnSB0
aHJlYWQ/Cj4gPiAKPiA+IE5vOyBwZW9wbGUgbWlnaHQgZm9yIGluc3RhbmNlIGNhcmUgYWJvdXQg
dGFpbCBsYXRlbmNpZXMgYmV0d2VlbiB0aGVpcgo+ID4gaWRlbnRpY2FsbHkgc3BlYydlZCB3b3Jr
ZXIgdGFza3MuCj4gCj4gSSB3b3VsZCBhcmd1ZSB0aGF0IHRob3NlIHVzZXJzIG5lZWQgdG8gdHVu
ZS9yZWR1Y2UgdGhlIGludHJhLW5vZGUgaGFuZG9mZgo+IHRocmVzaG9sZCBmb3IgdGhlaXIgbmVl
ZHMuIE9yIGRpc2FibGUgQ05BIGFsdG9nZXRoZXIuCgpJIHJlYWxseSBkb24ndCBsaWtlIGJvb3Qg
dGltZSBhcmd1bWVudHMgKG9yIHR1bmFibGVzIGluIGdlbmVyaWMpIGZvciBhCm1hY2hpbmUgdG8g
d29yayBhcyBpdCBzaG91bGQuCgpUaGUgZGVmYXVsdCByZWFsbHkgc2hvdWxkICdqdXN0IHdvcmsn
LgoKPiBJbiBnZW5lcmFsLCBQZXRlciwgc2VlbXMgbGlrZSB5b3UgYXJlIG5vdCBvbiBib2FyZCB3
aXRoIHRoZSB3YXkgTG9uZ21hbgo+IHN1Z2dlc3RlZCB0byBoYW5kbGUgcHJpb3JpdGl6ZWQgdGhy
ZWFkcy4gQW0gSSByaWdodD8KClJpZ2h0LgoKUHJlc3VtYWJseSB5b3UgaGF2ZSBhIHdvcmtsb2Fk
IHdoZXJlIENOQSBpcyBhY3R1YWxseSBhIHdpbj8gVGhhdCBpcywKd2hhdCBpbnNwaXJlZCB5b3Ug
dG8gZ28gZG93biB0aGlzIHJvYWQ/IFdoaWNoIGFjdHVhbCBrZXJuZWwgbG9jayBpcyBzbwpjb250
ZW5kZWQgb24gTlVNQSBtYWNoaW5lcyB0aGF0IHdlIG5lZWQgdG8gZG8gdGhpcz8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

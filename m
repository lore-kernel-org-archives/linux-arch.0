From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 1/5] locking/qspinlock: Rename mcs lock/unlock macros
 and make them more generic
Date: Sat, 25 Jan 2020 12:23:41 +0100
Message-ID: <20200125112341.GY11457@worktop.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-2-alex.kogan@oracle.com>
 <20200122091547.GU14879@hirez.programming.kicks-ass.net>
 <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <C608A39E-CAFC-4C79-9EB6-3DFD9621E3F6@oracle.com>
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
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBKYW4gMjMsIDIwMjAgYXQgMDY6NTE6MTFQTSAtMDUwMCwgQWxleCBLb2dhbiB3cm90
ZToKPiA+IE9uIEphbiAyMiwgMjAyMCwgYXQgNDoxNSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPiB3cm90ZToKCj4gPiBBbHNvLCBwYXNzX2xvY2sgc2VlbXMgdW5mb3J0
dW5hdGVseSBuYW1lZOKApgoKPiBXZWxsLCBJIGtub3cgdGhlIGd1eSB3aG8gc2hvdWxkIGJlIGJs
YW1lZCBmb3IgdGhhdCBvbmUgOikKPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS83LzE2LzIx
MiA8aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNy8xNi8yMTI+CgpIYSwgeWVzLCB0aGF0IGd1
eSBpcyBhbiBpZGlvdCBzb21ldGltZXMgOy0pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

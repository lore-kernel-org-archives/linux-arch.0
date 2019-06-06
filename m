From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 6 Jun 2019 11:21:48 -0400
Message-ID: <6426D627-77EE-471C-B02A-A85271B666E9@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
 <20190605204003.GC3402@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190605204003.GC3402@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, Steven Sistare <steven.sistare@oracle.com>, linux-kernel@vger.kernel.org, Rahul Yadav <rahul.x.yadav@oracle.com>, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Pj4gQWxzbywgdGhlIHBhcmF2aXJ0IGNvZGUgaXMgdW5kZXIgYXJjaC94ODYsIHdoaWxlIENOQSBp
cyBnZW5lcmljIChub3QKPj4geDg2LXNwZWNpZmljKS4gIERvIHlvdSBzdGlsbCB3YW50IHRvIHNl
ZSBDTkEtcmVsYXRlZCBwYXRjaGluZyByZXNpZGluZwo+PiB1bmRlciBhcmNoL3g4Nj8KPj4gCj4+
IFdlIHN0aWxsIG5lZWQgYSBjb25maWcgb3B0aW9uIChzb21ldGhpbmcgbGlrZSBOVU1BX0FXQVJF
X1NQSU5MT0NLUykgdG8KPj4gZW5hYmxlIENOQSBwYXRjaGluZyB1bmRlciB0aGlzIGNvbmZpZyBv
bmx5LCBjb3JyZWN0Pwo+IAo+IFRoZXJlIGlzIHRoZSBzdGF0aWNfY2FsbCgpIHN0dWZmIHRoYXQg
Y291bGQgYmUgZ2VuZXJpYzsgSSBwb3N0ZWQgYSBuZXcKPiB2ZXJzaW9uIG9mIHRoYXQgdG9kYXkg
KHg4NiBvbmx5IGZvciBub3csIGJ1dCBJSVJDIHRoZXJlJ3MgYXJtNjQgcGF0Y2hlcwo+IGZvciB0
aGF0IGFyb3VuZCBzb21ld2hlcmUgdG9vKS4KClRoZSBzdGF0aWNfY2FsbCB0ZWNobmlxdWUgYXBw
ZWFycyBhcyB0aGUgbW9yZSBkZXNpcmFibGUgbG9uZy10ZXJtIGFwcHJvYWNoLCBidXQgSSB0aGlu
ayBpdCB3b3VsZCBiZSBwcnVkZW50IHRvIGtlZXAgdGhlIHBhdGNoZXMgZGVjb3VwbGVkIGZvciBu
b3cgc28gd2UgY2FuIG1vdmUgZm9yd2FyZCB3aXRoIGxlc3MgZW50YW5nbGVtZW50cy4KU28gdW5s
ZXNzIGFueW9uZSBvYmplY3RzLCB3ZSB3aWxsIHdvcmsgb24gcGx1Z2dpbmcgaW50byB0aGUgZXhp
c3RpbmcgcGF0Y2hpbmcgZm9yIHB2LgpBbmQgd2Ugd2lsbCBrZWVwIHRoYXQgY29kZSB1bmRlciBh
cmNoL3g4NiwgYnV0IHdpbGwgYmUgb3BlbiBmb3IgYW55IHN1Z2dlc3Rpb24gdG8gbW92ZSBpdCBl
bHNld2hlcmUuCgpUaGFua3MhCuKAlCBBbGV4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Fri, 9 Oct 2015 10:44:18 -0700
Message-ID: <20151009174418.GW3910@linux.vnet.ibm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
 <20151009112554.GB3816@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20151009112554.GB3816@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCBPY3QgMDksIDIwMTUgYXQgMDE6MjU6NTRQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEg
d3JvdGU6Cj4gT24gRnJpLCBPY3QgMDksIDIwMTUgYXQgMTA6NTE6MjlBTSArMDEwMCwgV2lsbCBE
ZWFjb24gd3JvdGU6Cj4gPiA+IFRoZSBjb3JyZXNwb25kaW5nIGxpdG11cyB0ZXN0cyBhcmUgYmVs
b3cuCj4gPiAKPiA+IEhvdyBkbyBwZW9wbGUgZmVlbCBhYm91dCBpbmNsdWRpbmcgdGhlc2UgaW4g
bWVtb3J5LWJhcnJpZXJzLnR4dD8gSSBmaW5kCj4gPiB0aGVtIGNvbnNpZGVyYWJseSBlYXNpZXIg
dG8gcmVhZCB0aGFuIG91ciBjdXJyZW50IGtlcm5lbCBjb2RlICsgbGlzdCBvZgo+ID4gcG9zc2li
bGUgb3JkZXJpbmdzICsgd2FsbCBvZiB0ZXh0LCBidXQgdGhlcmUncyBhIGdvb2QgY2hhbmNlIHRo
YXQgbXkKPiA+IGJyYWluIGhhcyBiZWVuIGNvcnJ1cHRlZCBmcm9tIHN0YXJpbmcgYXQgdGhpcyBz
dHVmZiBmb3IgdG9vIGxvbmcuCj4gCj4gWW91ciBicmFpbiBpcyBjb3JydXB0IChidXQgdGhlbiwg
c28gcHJvYmFibHkgaXMgbWluZSwganVzdCBkaWZmZXJlbnRseQo+IHNvKS4KPiAKPiBJJ3ZlIG5v
dCB5ZXQgbWFzdGVyZWQgdGhlIGtuYWNrIG9mIHJlYWRpbmcgdGhvc2UgdGhpbmdzOyB0aGVuIGFn
YWluLCBJCj4gc3VzcGVjdCBpdHMgbm90IHRvbyBoYXJkLCBqdXN0IG5vdCBzb21ldGhpbmcgSSd2
ZSBoYWQgdGhlIHRpbWUgdG8gcGxheQo+IHdpdGguCgpJdCBkb2VzIHRha2UgYSBiaXQgb2YgcHJh
Y3RpY2UsIGJ1dCBpcyB3b3J0aCB0aGUgZWZmb3J0LiAgT2YgY291cnNlLApJIC13b3VsZC0gc2F5
IHRoYXQuICA7LSkKCgkJCQkJCQlUaGFueCwgUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8v
bGludXhwcGMtZGV2

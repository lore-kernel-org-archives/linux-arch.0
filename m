From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 14/52] powerpc, sysfs: Fix CPU hotplug callback
 registration
Date: Fri, 07 Mar 2014 13:57:31 +1100
Message-ID: <1394161051.26321.71.camel@pasglop>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
 <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
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
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com, linux@arm.linux.org.uk, akpm@linux-foundation.org, Wang Dongsheng <dongsheng.wang@freescale.com>, peterz@infradead.org, rusty@rustcorp.com.au, rjw@rjwysocki.net, oleg@redhat.com, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org, tj@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

T24gRnJpLCAyMDE0LTAyLTE0IGF0IDEzOjIyICswNTMwLCBTcml2YXRzYSBTLiBCaGF0IHdyb3Rl
Ogo+IFN1YnN5c3RlbXMgdGhhdCB3YW50IHRvIHJlZ2lzdGVyIENQVSBob3RwbHVnIGNhbGxiYWNr
cywgYXMgd2VsbCBhcyBwZXJmb3JtCj4gaW5pdGlhbGl6YXRpb24gZm9yIHRoZSBDUFVzIHRoYXQg
YXJlIGFscmVhZHkgb25saW5lLCBvZnRlbiBkbyBpdCBhcyBzaG93bgo+IGJlbG93Ogo+IAo+IAln
ZXRfb25saW5lX2NwdXMoKTsKPiAKPiAJZm9yX2VhY2hfb25saW5lX2NwdShjcHUpCj4gCQlpbml0
X2NwdShjcHUpOwo+IAo+IAlyZWdpc3Rlcl9jcHVfbm90aWZpZXIoJmZvb2Jhcl9jcHVfbm90aWZp
ZXIpOwo+IAo+IAlwdXRfb25saW5lX2NwdXMoKTsKClRoaXMgcGF0Y2ggYnJlYWtzIGEgZ29vZCBo
YWxmIG9mIG15IHRlc3QgY29uZmlncyB3aXRoOgoKL2hvbWUvYmVuaC9saW51eC1wb3dlcnBjLXRl
c3QvYXJjaC9wb3dlcnBjL2tlcm5lbC9zeXNmcy5jOiBJbiBmdW5jdGlvbiAndG9wb2xvZ3lfaW5p
dCc6Ci9ob21lL2JlbmgvbGludXgtcG93ZXJwYy10ZXN0L2FyY2gvcG93ZXJwYy9rZXJuZWwvc3lz
ZnMuYzo5Nzk6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdjcHVf
bm90aWZpZXJfcmVnaXN0ZXJfYmVnaW4nIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xh
cmF0aW9uXQovaG9tZS9iZW5oL2xpbnV4LXBvd2VycGMtdGVzdC9hcmNoL3Bvd2VycGMva2VybmVs
L3N5c2ZzLmM6MTAwNDoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g
J19fcmVnaXN0ZXJfY3B1X25vdGlmaWVyJyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0KL2hvbWUvYmVuaC9saW51eC1wb3dlcnBjLXRlc3QvYXJjaC9wb3dlcnBjL2tlcm5l
bC9zeXNmcy5jOjEwMDY6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdjcHVfbm90aWZpZXJfcmVnaXN0ZXJfZG9uZScgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24t
ZGVjbGFyYXRpb25dCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2VbMl06ICoqKiBbYXJjaC9wb3dlcnBjL2tlcm5lbC9zeXNmcy5vXSBFcnJvciAxCm1ha2VbMl06
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QK
TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xp
c3RpbmZvL2xpbnV4cHBjLWRldg==

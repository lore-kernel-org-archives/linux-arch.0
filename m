From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Date: Thu, 04 Sep 2014 19:08:48 -0700
Message-ID: <54091B30.7080100@zytor.com>
References: <20140712181328.GA8738@redhat.com>	
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>	
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <54090AF4.7060406@hurleysoftware.com>
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
To: Peter Hurley <peter@hurleysoftware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@ACULAB.COM>
Cc: Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

T24gMDkvMDQvMjAxNCAwNTo1OSBQTSwgUGV0ZXIgSHVybGV5IHdyb3RlOgo+IEkgaGF2ZSBubyBp
ZGVhIGhvdyBwcmV2YWxlbnQgdGhlIGV2NTYgaXMgY29tcGFyZWQgdG8gdGhlIGV2NS4KPiBTdGls
bCB3ZSdyZSB0YWxraW5nIGFib3V0IGEgY2hpcCB0aGF0IGNhbWUgb3V0IGluIDE5OTYuCgpBaCB5
ZXMsIEkgc3RhbmQgY29ycmVjdGVkLiAgQWNjb3JkaW5nIHRvIFdpa2lwZWRpYSwgdGhlIGFmZmVj
dGVkIENQVXMKd2VyZSBhbGwgdGhlIDIxMDZ4IENQVXMgKEVWNCwgRVY0NSwgTENBNCwgTENBNDUp
IHBsdXMgdGhlIDIxMTY0IHdpdGggbm8Kc3VmZml4IChFVjUpLiAgSG93ZXZlciwgd2UncmUgc3Rp
bGwgdGFsa2luZyBhYm91dCBtdXNldW0gcGllY2VzIGhlcmUuCgpJIHdvbmRlciB3aGF0IHRoZSBv
bmUgSSBoYXZlIGluIG15IGdhcmFnZSBpcy4uLiBJJ20gc3VyZSBJIGNvdWxkIGVtdWxhdGUKaXQg
ZmFzdGVyLCB0aG91Z2guCgoJLWhwYQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBj
LWRldg==

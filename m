From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: bit fields && data tearing
Date: Fri, 5 Sep 2014 20:16:48 +1200
Message-ID: <20140905081648.GB5281@omega>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <54091B30.2090509@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBTZXAgMDQsIDIwMTQgYXQgMDc6MDg6NDhQTSAtMDcwMCwgSC4gUGV0ZXIgQW52aW4g
d3JvdGU6Cj4gT24gMDkvMDQvMjAxNCAwNTo1OSBQTSwgUGV0ZXIgSHVybGV5IHdyb3RlOgo+ID4g
SSBoYXZlIG5vIGlkZWEgaG93IHByZXZhbGVudCB0aGUgZXY1NiBpcyBjb21wYXJlZCB0byB0aGUg
ZXY1Lgo+ID4gU3RpbGwgd2UncmUgdGFsa2luZyBhYm91dCBhIGNoaXAgdGhhdCBjYW1lIG91dCBp
biAxOTk2Lgo+IAo+IEFoIHllcywgSSBzdGFuZCBjb3JyZWN0ZWQuICBBY2NvcmRpbmcgdG8gV2lr
aXBlZGlhLCB0aGUgYWZmZWN0ZWQgQ1BVcwo+IHdlcmUgYWxsIHRoZSAyMTA2eCBDUFVzIChFVjQs
IEVWNDUsIExDQTQsIExDQTQ1KSBwbHVzIHRoZSAyMTE2NCB3aXRoIG5vCj4gc3VmZml4IChFVjUp
LiAgSG93ZXZlciwgd2UncmUgc3RpbGwgdGFsa2luZyBhYm91dCBtdXNldW0gcGllY2VzIGhlcmUu
CgpZZXMsIHRoYXQgaXMgY29ycmVjdCwgRVY1NiBpcyB0aGUgZmlyc3QgQWxwaGEgQ1BVIHRvIGhh
dmUgdGhlIGJ5dGUtd29yZApleHRlbnNpb24gKEJXWCkgQ1BVIGluc3RydWN0aW9ucy4KCkl0IHdv
dWxkIG5vdCB3b3JyeSBtZSBpZiB0aGUga2VybmVsIGRlY2lkZWQgdG8gYXNzdW1lIGF0b21pYyBh
bGlnbmVkCnNjYWxhciBhY2Nlc3NlcyBmb3IgYWxsIGFyY2hlcywgdGh1cyB0ZXJtaW5hdGluZyBz
dXBwb3J0IGZvciBBbHBoYXMKd2l0aG91dCBCV1guCgpUaGUgWCBzZXJ2ZXIsIGV2ZXIgc2luY2Ug
dGhlIGxpYnBjaWFjY2VzcyBjaGFuZ2UsIGRvZXMgbm90IHdvcmsgb24KQWxwaGFzIHdpdGhvdXQg
QldYLgoKRGViaWFuIEFscGhhIChwcmV0dHkgbXVjaCB1cCB0byBkYXRlIGF0IERlYmlhbi1Qb3J0
cykgaXMgc3RpbGwgY29tcGlsZWQKZm9yIGFsbCBBbHBoYXMsIGkuZS4sIHdpdGhvdXQgQldYLiAg
VGhlIGxhc3QgYXR0ZW1wdCB0byBzdGFydCBjb21waWxpbmcKRGViaWFuIEFscGhhIHdpdGggQldY
LCBhYm91dCB0aHJlZSB5ZWFycyBhZ28gd2hlbiBBbHBoYSB3YXMga2lja2VkIG91dAp0byBEZWJp
YW4tUG9ydHMgcmVzdWx0ZWQgaW4gYSBjb3VwbGUgb3Igc28gY29tcGxhaW50cyBzbyBnb3Qgbm93
aGVyZS4KSXQncyBmcnVzdHJhdGluZyBzdXBwb3J0aW5nIHRoZSBsb3dlc3QgY29tbW9uIGRlbW9u
aW5hdG9yIGFzIG1hbnkgb2YKdGhlIGJ1Z3Mgc3BlY2lmaWMgdG8gQWxwaGEgY2FuIGJlIHJlc29s
dmVkIGJ5IHJlY29tcGlsaW5nIHdpdGggdGhlIEJXWC4KVGhlIGtlcm5lbCBubyBsb25nZXIgc3Vw
cG9ydGluZyBBbHBoYXMgd2l0aG91dCBCV1ggbWlnaHQganVzdCBiZSB0aGUKaW5jZW50aXZlIHdl
IG5lZWQgdG8gc3dpdGNoIERlYmlhbiBBbHBoYSB0byBjb21waWxpbmcgd2l0aCBCV1guCgpDaGVl
cnMKTWljaGFlbC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
ZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

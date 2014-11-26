From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Wed, 26 Nov 2014 17:23:34 +0200
Message-ID: <20141126152334.GA9648@redhat.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
 <20141126070258.GA25523@redhat.com>
 <20141126110504.511b733a@thinkpad-w530>
 <20141126151729.GB9612@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20141126151729.GB9612@redhat.com>
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
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, paulus@samba.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCBOb3YgMjYsIDIwMTQgYXQgMDU6MTc6MjlQTSArMDIwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIFdlZCwgTm92IDI2LCAyMDE0IGF0IDExOjA1OjA0QU0gKzAxMDAsIERh
dmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+ID4gPiBXaGF0J3MgdGhlIHBhdGggeW91IGFyZSB0cnlp
bmcgdG8gZGVidWc/Cj4gPiAKPiA+IFdlbGwsIHdlIGhhZCBhIHByb2JsZW0gd2hlcmUgd2UgaGVs
ZCBhIHNwaW5fbG9jayBhbmQgY2FsbGVkCj4gPiBjb3B5Xyhmcm9tfHRvKV91c2VyKCkuIFdlIGV4
cGVyaWVuY2VkIHZlcnkgcmFuZG9tIGRlYWRsb2NrcyB0aGF0IHRvb2sgc29tZSBndXkKPiA+IGFs
bW9zdCBhIHdlZWsgdG8gZGVidWcuIFRoZSBzaW1wbGUgbWlnaHRfc2xlZXAoKSBjaGVjayB3b3Vs
ZCBoYXZlIHNob3dlZCB0aGlzCj4gPiBlcnJvciBpbW1lZGlhdGVseS4KPiAKPiBUaGlzIG11c3Qg
aGF2ZSBiZWVuIGEgdmVyeSBvbGQga2VybmVsLgo+IEEgbW9kZXJuIGtlcm5lbCB3aWxsIHJldHVy
biBhbiBlcnJvciBmcm9tIGNvcHlfdG9fdXNlci4KPiBXaGljaCBpcyByZWFsbHkgdGhlIHBvaW50
IG9mIHRoZSBwYXRjaCB5b3UgYXJlIHRyeWluZyB0byByZXZlcnQuCgpUaGF0J3MgYXNzdW1pbmcg
eW91IGRpc2FibGVkIHByZWVtcHRpb24uIElmIHlvdSBkaWRuJ3QsIGFuZCB0YWtlCmEgc3Bpbmxv
Y2ssIHlvdSBoYXZlIGRlYWRsb2NrcyBldmVuIHdpdGhvdXQgdXNlcnNwYWNlIGFjY2Vzcy4KCi0t
IApNU1QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRw
czovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

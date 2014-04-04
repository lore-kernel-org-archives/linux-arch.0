From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Fri, 04 Apr 2014 09:18:43 -0700
Message-ID: <533EDB63.8090909@intel.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
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
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org, rusty@rustcorp.com.au, paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: linux-arch.vger.kernel.org

T24gMDQvMDMvMjAxNCAxMToyNyBQTSwgTWFkaGF2YW4gU3Jpbml2YXNhbiB3cm90ZToKPiBUaGlz
IHBhdGNoIGNyZWF0ZXMgaW5mcmFzdHJ1Y3R1cmUgdG8gbW92ZSB0aGUgRkFVTFRfQVJPVU5EX09S
REVSCj4gdG8gYXJjaC8gdXNpbmcgS2NvbmZpZy4gVGhpcyB3aWxsIGVuYWJsZSBhcmNoaXRlY3R1
cmUgbWFpbnRhaW5lcnMKPiB0byBkZWNpZGUgb24gc3VpdGFibGUgRkFVTFRfQVJPVU5EX09SREVS
IHZhbHVlIGJhc2VkIG9uCj4gcGVyZm9ybWFuY2UgZGF0YSBmb3IgdGhhdCBhcmNoaXRlY3R1cmUu
IFBhdGNoIGFsc28gYWRkcwo+IEZBVUxUX0FST1VORF9PUkRFUiBLY29uZmlnIGVsZW1lbnQgaW4g
YXJjaC9YODYuCgpQbGVhc2UgZG9uJ3QgZG8gaXQgdGhpcyB3YXkuCgpJbiBtbS9LY29uZmlnLCBw
dXQKCgljb25maWcgRkFVTFRfQVJPVU5EX09SREVSCgkJaW50CgkJZGVmYXVsdCAxMjM0IGlmIFBP
V0VSUEMKCQlkZWZhdWx0IDQKClRoZSB3YXkgeW91IGhhdmUgaXQgbm93LCBldmVyeSBzaW5nbGUg
YXJjaGl0ZWN0dXJlIHRoYXQgbmVlZHMgdG8gZW5hYmxlCnRoaXMgaGFzIHRvIGdvIHB1dCB0aGF0
IGluIHRoZWlyIEtjb25maWcuICBUaGF0J3MgbWFkbmVzcy4gIFRoaXMgd2F5LAp5b3Ugb25seSBw
dXQgaXQgaW4gb25lIHBsYWNlLCBhbmQgZm9sa3Mgb25seSBoYXZlIHRvIGNhcmUgaWYgdGhleSB3
YW50CnRvIGNoYW5nZSB0aGUgZGVmYXVsdCB0byBiZSBzb21ldGhpbmcgb3RoZXIgdGhhbiA0LgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Wed, 09 Apr 2014 08:46:41 -0700
Message-ID: <53456B61.1040901@intel.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <5344A312.80802@linux.vnet.ibm.com>
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

T24gMDQvMDgvMjAxNCAwNjozMiBQTSwgTWFkaGF2YW4gU3Jpbml2YXNhbiB3cm90ZToKPj4gPiBJ
biBtbS9LY29uZmlnLCBwdXQKPj4gPiAKPj4gPiAJY29uZmlnIEZBVUxUX0FST1VORF9PUkRFUgo+
PiA+IAkJaW50Cj4+ID4gCQlkZWZhdWx0IDEyMzQgaWYgUE9XRVJQQwo+PiA+IAkJZGVmYXVsdCA0
Cj4+ID4gCj4+ID4gVGhlIHdheSB5b3UgaGF2ZSBpdCBub3csIGV2ZXJ5IHNpbmdsZSBhcmNoaXRl
Y3R1cmUgdGhhdCBuZWVkcyB0byBlbmFibGUKPj4gPiB0aGlzIGhhcyB0byBnbyBwdXQgdGhhdCBp
biB0aGVpciBLY29uZmlnLiAgVGhhdCdzIG1hZG5lc3MuICBUaGlzIHdheSwKPiBJIHRob3VnaCBh
Ym91dCBpdCBhbmQgZGVjaWRlZCBub3QgdG8gZG8gdGhpcyB3YXkgYmVjYXVzZSwgaW4gZnV0dXJl
LAo+IHN1YiBwbGF0Zm9ybXMgb2YgdGhlIGFyY2hpdGVjdHVyZSBtYXkgZGVjaWRlIHRvIGNoYW5n
ZSB0aGUgdmFsdWVzLiBBbHNvLAo+IGFkZGluZyBhbiBpZiBsaW5lIGZvciBlYWNoIGFyY2hpdGVj
dHVyZSB3aXRoIGRpZmZlcmVudCBzdWIgcGxhdGZvcm1zCj4gb3JpbmcgdG8gaXQgd2lsbCBsb29r
IG1lc3N5LgoKSSdtIG5vdCBzdXJlIHdoeSBJJ20gdHJ5aW5nIGhlcmUgYW55IG1vcmUuICBZb3Ug
ZG8gc2VlbSBxdWl0ZSBjb250ZW50IHRvCmFkZCBhcyBtdWNoIGNydWZ0IHRvIHBwYyBhbmQgZXZl
cnkgb3RoZXIgYXJjaGl0ZWN0dXJlIGFzIHBvc3NpYmxlLiAgSWYKeW91ciB0aGVvcmV0aWNhbCBz
Y2VuYXJpbyBwb3BzIHVwLCB5b3Ugc2ltcGx5IGRvIHRoaXMgaW4gcHBjOgoKY29uZmlnIEFSQ0hf
RkFVTFRfQVJPVU5EX09SREVSCglpbnQKCWRlZmF1bHQgOTk5CglkZWZhdWx0IDg4OCBpZiBPVEhF
Ul9TSUxMWV9QT1dFUlBDX1NVQkFSQ0gKCkJ1dCAqT05MWSogaW4gdGhlIGFyY2hpdGVjdHVyZXMg
dGhhdCBjYXJlIGFib3V0IGRvaW5nIHRoYXQgc3R1ZmYuICBZb3UKbGVhdmUgZXZlcnkgb3RoZXIg
YXJjaGl0ZWN0dXJlIG9uIHRoZSBwbGFuZXQgYWxvbmUuICBUaGVuLCBpbiBtbS9LY29uZmlnOgoK
Y29uZmlnIEZBVUxUX0FST1VORF9PUkRFUgoJaW50CglkZWZhdWx0IEFSQ0hfRkFVTFRfQVJPVU5E
X09SREVSIGlmIEFSQ0hfRkFVTFRfQVJPVU5EX09SREVSCglkZWZhdWx0IDQKCllvdXIgd2F5IHN0
aWxsIHJlcXVpcmVzIGdvaW5nIGFuZCBpbmRpdmlkdWFsbHkgdG91Y2hpbmcgZXZlcnkgc2luZ2xl
CmFyY2hpdGVjdHVyZSdzIEtjb25maWcgdGhhdCB3YW50cyB0byBlbmFibGUgZmF1bHQgYXJvdW5k
LiAgVGhhdCdzIG5vdCBhbgphY2NlcHRhYmxlIHNvbHV0aW9uLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0Ckxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0
aW5mby9saW51eHBwYy1kZXY=

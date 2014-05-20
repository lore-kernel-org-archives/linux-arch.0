From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
Date: Mon, 19 May 2014 19:34:27 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1405191930130.3574@eggly.anvils>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au> <53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
 <87d2f9jlpd.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <87d2f9jlpd.fsf@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCAyMCBNYXkgMjAxNCwgUnVzdHkgUnVzc2VsbCB3cm90ZToKPiBIdWdoIERpY2tpbnMg
PGh1Z2hkQGdvb2dsZS5jb20+IHdyaXRlczoKPiA+PiBPbiBNb25kYXkgMTkgTWF5IDIwMTQgMDU6
NDIgQU0sIFJ1c3R5IFJ1c3NlbGwgd3JvdGU6Cj4gPj4gPiAKPiA+PiA+IFBlcmhhcHMgd2UgdHJ5
IHRvIGdlbmVyYWxpemUgZnJvbSB0d28gZGF0YSBwb2ludHMgKGEgc2xpZ2h0IGltcHJvdmVtZW50
Cj4gPj4gPiBvdmVyIGRvaW5nIGl0IGZyb20gMSEpLCBlZzoKPiA+PiA+IAo+ID4+ID4gLyogNCBz
ZWVtcyBnb29kIGZvciA0ay1wYWdlIHg4NiwgMCBzZWVtcyBnb29kIGZvciA2NGsgcGFnZSBwcGM2
NCwgc286ICovCj4gPj4gPiB1bnNpZ25lZCBpbnQgZmF1bHRfYXJvdW5kX29yZGVyIF9fcmVhZF9t
b3N0bHkgPQo+ID4+ID4gICAgICAgICAoMTYgLSBQQUdFX1NISUZUIDwgMCA/IDAgOiAxNiAtIFBB
R0VfU0hJRlQpOwo+ID4KPiA+IFJ1c3R5J3MgYmltb2RhbCBhbnN3ZXIgZG9lc24ndCBzZWVtIHRo
ZSByaWdodCBzdGFydGluZyBwb2ludCB0byBtZS4KPiAKPiA/ICBJdCdzIG5vdCBiaW1vZGFsLCBp
dCdzIGdyYWRlZC4gIEkgdGhpbmsgeW91IG1pc3JlYWQ/CgpZaWtlcywgd29yc2UgdGhhbiBtaXNy
ZWFkLCBtb3JlIGxpa2UgSSB3YXMgdG9vIHJ1ZGUgZXZlbiB0byByZWFkOiBzb3JyeSEKCkh1Z2gK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

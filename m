From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 2/2] powerpc/pseries: init fault_around_order for
 pseries
Date: Tue, 20 May 2014 13:33:58 +0530
Message-ID: <537B0C6E.4030501@linux.vnet.ibm.com>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
 <20140520002834.aefb5a90.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20140520002834.aefb5a90.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au, dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: linux-arch.vger.kernel.org

T24gVHVlc2RheSAyMCBNYXkgMjAxNCAxMjo1OCBQTSwgQW5kcmV3IE1vcnRvbiB3cm90ZToKPiBP
biBUaHUsICA4IE1heSAyMDE0IDE0OjU4OjE2ICswNTMwIE1hZGhhdmFuIFNyaW5pdmFzYW4gPG1h
ZGR5QGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4gCj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcHNlcmllcy9wc2VyaWVzLmgKPj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jt
cy9wc2VyaWVzL3BzZXJpZXMuaAo+PiBAQCAtMTcsNiArMTcsOCBAQCBzdHJ1Y3QgZGV2aWNlX25v
ZGU7Cj4+ICBleHRlcm4gdm9pZCByZXF1ZXN0X2V2ZW50X3NvdXJjZXNfaXJxcyhzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wLAo+PiAgCQkJCSAgICAgICBpcnFfaGFuZGxlcl90IGhhbmRsZXIsIGNvbnN0
IGNoYXIgKm5hbWUpOwo+PiAgCj4+ICtleHRlcm4gdW5zaWduZWQgaW50IGZhdWx0X2Fyb3VuZF9v
cmRlcjsKPiAKPiBUaGlzIGlzbid0IGFuIGFwcHJvcHJpYXRlIGhlYWRlciBmaWxlIGZvciBleHBv
cnRpbmcgc29tZXRoaW5nIGZyb20gY29yZQo+IG1tIC0gd2hhdCBoYXBwZW5zIGlmIGFyY2gvbW4x
MDMwMCB3YW50cyBpdD8uCj4KPiBJIGd1ZXNzIGluY2x1ZGUvbGludXgvbW0uaCBpcyB0aGUgcGxh
Y2UuCj4gCgpSdXN0eSBhbHJlYWR5IHN1Z2dlc3RlZCB0aGlzLiBNeSBiYWQuICBSZWFzb24gZm9y
IGFkZGluZyBpdCBoZXJlIHdhcwp0aGF0LCBJIGRpZCB0aGUgcGVyZm9ybWFuY2UgdGVzdCBmb3Ig
dGhpcyBwbGF0Zm9ybS4gV2lsbCBjaGFuZ2UgYW5kIHNlbmQKaXQgb3V0LgoKVGhhbmtzIGZvciBy
ZXZpZXcKUmVnYXJkcwpNYWRkeQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
	dma-mapping: provide a generic dma-noncoherent implementation)
Date: Fri, 18 May 2018 13:35:08 -0700
Message-ID: <cecfe6bd-ef1f-1e25-bfcf-992d1f828efb@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
	<5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
	<20180518175004.GF17671@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180518175004.GF17671-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monst>
List-Id: linux-arch.vger.kernel.org

T24gMDUvMTgvMjAxOCAxMDo1MCBBTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IHdyb3RlOgo+
IE9uIEZyaSwgTWF5IDE4LCAyMDE4IGF0IDEwOjIwOjAyQU0gLTA3MDAsIFZpbmVldCBHdXB0YSB3
cm90ZToKPj4gSSBuZXZlciB1bmRlcnN0b29kIHRoZSBuZWVkIGZvciB0aGlzIGRpcmVjdGlvbi4g
QW5kIGlmIG1lbW9yeSBzZXJ2ZXMgbWUKPj4gcmlnaHQsIGF0IHRoYXQgdGltZSBJIHdhcyBzZWVp
bmcgdHdpY2UgdGhlIGFtb3VudCBvZiBjYWNoZSBmbHVzaGluZyAhCj4gSXQncyBuZWNlc3Nhcnku
ICBUYWtlIGEgbW9tZW50IHRvIHRoaW5rIGNhcmVmdWxseSBhYm91dCB0aGlzOgo+Cj4gCWRtYV9t
YXBfc2luZ2xlKCwgZGlyKQo+Cj4gCWRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KCwgZGlyKQo+Cj4g
CWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKCwgZGlyKQo+Cj4gCWRtYV91bm1hcF9zaW5nbGUo
LCBkaXIpCgpBcyBhbiBhc2lkZSwgZG8gdGhlc2UgaW1wbHkgYSBzdGF0ZSBtYWNoaW5lIG9mIHNv
cnRzIC0gZG9lcyBhIGRyaXZlciBuZWVkcyB0byAKYWx3YXlzIGNhbGwgbWFwX3NpbmdsZSBmaXJz
dCA/CgpNeSBvcmlnaW5hbCBwb2ludCBvZiBjb250ZW50aW9uL2NvbmZ1c2lvbiBpcyB0aGUgc3Bl
Y2lmaWMgY29tYmluYXRpb25zIG9mIEFQSSBhbmQgCmRpcmVjdGlvbiwgc3BlY2lmaWNhbGx5IGZv
cl9jcHUoVE9fREVWKSBhbmQgZm9yX2RldmljZShUT19DUFUpCgpTZW1hbnRpY2FsbHkgd2hhdCBk
b2VzIGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KFRPX0RFVikgZXZlbiBpbXBseSBmb3IgYSBub24g
ZG1hIApjb2hlcmVudCBhcmNoLgpZb3VyIHRhYmxlcyBiZWxvdyBoYXZlICJub25lIiBmb3IgYm90
aCwgaW1wbHlpbmcgaXQgaXMgdW5saWtlbHkgdG8gYmUgYSByZWFsIApjb21iaW5hdGlvbiAoZm9y
IEFSTSBhbmQgQVJDIGF0bGVhc3QpLgoKVGhlIG90aGVyIGNhc2UsIGFjdHVhbGx5IEBkaXIgVE9f
Q1BVLCBpbmRlcGVuZGVudCBvZiBmb3Jfe2NwdSwgZGV2aWNlfcKgIGltcGxpZXMgCmRyaXZlciBp
bnRlbmRzIHRvIHRvdWNoIGl0IGFmdGVyIHRoZSBjYWxsLCBzbyBpdCB3b3VsZCBpbnZhbGlkYXRl
IGFueSBzdHJheSBsaW5lcywgCnVuY29uZGl0aW9uYWxseSAoYW5kIG5vdCBqdXN0IGZvciBzcGVj
dWxhdGl2ZSBwcmVmZXRjaCBjYXNlKS4KCgo+IEluIHRoZSBjYXNlIG9mIGEgRE1BLWluY29oZXJl
bnQgYXJjaGl0ZWN0dXJlLCB0aGUgb3BlcmF0aW9ucyBkb25lIGF0IGVhY2gKPiBzdGFnZSBkZXBl
bmQgb24gdGhlIGRpcmVjdGlvbiBhcmd1bWVudDoKPgo+IAltYXAJCWZvcl9jcHUJCWZvcl9kZXZp
Y2UJdW5tYXAKPiBUT19ERVYJd3JpdGViYWNrCW5vbmUJCXdyaXRlYmFjawlub25lCj4gVE9fQ1BV
CWludmFsaWRhdGUJaW52YWxpZGF0ZSoJaW52YWxpZGF0ZQlpbnZhbGlkYXRlKgo+IEJJRElSCXdy
aXRlYmFjawlpbnZhbGlkYXRlCXdyaXRlYmFjawlpbnZhbGlkYXRlCj4KPiAqIC0gb25seSBuZWNl
c3NhcnkgaWYgdGhlIENQVSBzcGVjdWxhdGl2ZWx5IHByZWZldGNoZXMuCj4KPiBUaGUgbXVsdGlw
bGUgaW52YWxpZGF0aW9ucyBmb3IgdGhlIFRPX0NQVSBjYXNlIGhhbmRsZXMgZGlmZmVyZW50Cj4g
Y29uZGl0aW9ucyB0aGF0IGNhbiByZXN1bHQgaW4gZGF0YSBjb3JydXB0aW9uLCBhbmQgZm9yIHNv
bWUgQ1BVcywgYWxsCj4gZm91ciBhcmUgbmVjZXNzYXJ5LgoKQ2FuIHlvdSBwbGVhc2UgZXhwbGFp
biBpbiBzb21lIG1vcmUgZGV0YWlsLCBUT19DUFUgcm93LCB3aHkgaW52YWxpZGF0ZSBpcyAKY29u
ZGl0aW9uYWwgc29tZXRpbWVzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=

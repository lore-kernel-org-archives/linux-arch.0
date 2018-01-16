From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: consolidate swiotlb dma_map implementations
Date: Tue, 16 Jan 2018 09:52:28 +0100
Message-ID: <485e6f8b-ef22-0792-1acc-3fefe203040c@amd.com>
References: <20180110080932.14157-1-hch@lst.de>
	<20180116075338.GB12693@infradead.org>
	<76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
	<20180116082827.GA9211@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116082827.GA9211-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

QW0gMTYuMDEuMjAxOCB1bSAwOToyOCBzY2hyaWViIENocmlzdG9waCBIZWxsd2lnOgo+IE9uIFR1
ZSwgSmFuIDE2LCAyMDE4IGF0IDA5OjIyOjUyQU0gKzAxMDAsIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4+IEhpIEtvbnJhZCwKPj4KPj4gY2FuIHlvdSBzZW5kIHRoZSBmaXJzdCBwYXRjaCB0byBM
aW51cyBmb3IgaW5jbHVzaW9uIGluIDQuMTUgaWYgeW91IGhhdmVuJ3QKPj4gYWxyZWFkeSBkb25l
IHNvPwo+IEl0J3MgaW4gdGhlIDQuMTYgcXVldWUgd2l0aCBhIGNjIHRvIHN0YWJsZS4gIEkgZ3Vl
c3Mgd2UncmUgb2sgd2l0aAo+IGEgZHVwbGljYXRlIGNvbW1pdCBpZiB3ZSBoYXZlIHRvLgoKWWVh
aCwgd2hpbGUgaXQncyBvbmx5IGEgZmFsc2UgcG9zaXRpdmUgd2FybmluZyBpdCB3b3VsZCBiZSBy
ZWFsbHkgbmljZSAKdG8gaGF2ZSBpbiA0LjE1LgoKSXQgYWZmZWN0cyBhbGwgZHJpdmVycyB1c2lu
ZyBUVE0gaW4gdGhlIHN5c3RlbSBhbmQgbm90IGp1c3QgdGhlIHR3byBJJ20gCnRoZSBtYWludGFp
bmVyIG9mLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=

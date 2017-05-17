From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
Date: Wed, 17 May 2017 10:47:30 +0530
Message-ID: <f5f8de4a-73a1-a32f-2736-2a7e64bfaa1a@codeaurora.org>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
	<20170516140943.ps2yufiukz6iurpl@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170516140943.ps2yufiukz6iurpl@latitude>
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
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: linux-arch.vger.kernel.org

SGksCgpPbiA1LzE2LzIwMTcgNzozOSBQTSwgSm9uYXRoYW4gTmV1c2Now6RmZXIgd3JvdGU6Cj4g
SGksIEkgaGF2ZSBhIGZldyBzdWdnZXN0aW9ucyBvbiBob3cgdG8gbWFrZSB0aGlzIGNvbW1pdCBt
ZXNzYWdlIG1vcmUKPiByZWFkYWJsZToKPiAKPiBPbiBUdWUsIE1heSAxNiwgMjAxNyBhdCAxMDo1
NDoxM0FNICswNTMwLCBTcmljaGFyYW4gUiB3cm90ZToKPj4gV2hpbGUgcmV0dXJuaW5nIEVQUk9C
RV9ERUZFUiBmb3IgaW9tbXUgbWFzdGVycwo+IAo+IEFkZCBhIGNvbW1hIGF0IHRoZSBlbmQgb2Yg
dGhpcyBsaW5lCj4gCj4+IHRha2UgaW4gdG8gYWNjb3VudCBvZiBpb21tdSBub2RlcyB0aGF0IGNv
dWxkIGJlCj4gCj4gcy9pbiB0by9pbnRvLwo+IHMvb2YgaW9tbXUvb2ZfaW9tbXUvCj4gCgpvaywg
d2lsbCBjb3JyZWN0IHRoZSBhYm92ZS4KClJlZ2FyZHMsCiBTcmljaGFyYW4KCj4+IG1hcmtlZCBp
biBEVCBhcyAnc3RhdHVzPWRpc2FibGVkJywgaW4gd2hpY2ggY2FzZQo+PiBzaW1wbHkgcmV0dXJu
IE5VTEwgYW5kIGxldCB0aGUgbWFzdGVyJ3MgcHJvYmUKPj4gY29udGludWUgcmF0aGVyIHRoYW4g
ZGVmZXJyaW5nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTcmljaGFyYW4gUiA8c3JpY2hhcmFuQGNv
ZGVhdXJvcmEub3JnPgo+PiBUZXN0ZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0u
Y29tPgo+PiBBY2tlZC1ieTogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4gCj4g
Cj4gVGhhbmtzLAo+IEpvbmF0aGFuIE5ldXNjaMOkZmVyCj4gCgotLSAKIlFVQUxDT01NIElORElB
LCBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1i
ZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=

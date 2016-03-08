From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: [PATCH v5 5/9] dmaengine: rcar-dmac: slave address are physical
Date: Tue,  8 Mar 2016 03:42:50 +0100
Message-ID: <1457404974-1800-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

U2xhdmUgYWRkcmVzc2VzIGNvbWluZyBmcm9tIGEgY2xpZW50IGlzIHBoeXNpY2FsIG5vdCBkbWEu
IFN0b3JlIHRoZQphZGRyZXNzIHVzaW5nIHRoZSBjb3JyZWN0IGRhdGEgdHlwZS4gVGhpcyBpcyBp
biBwcmVwYXJhdGlvbiBmb3IgaG9va2luZwp1cCB0aGUgZG1hLW1hcHBpbmcgQVBJIHRvIHRoZSBz
bGF2ZSBhZGRyZXNzZXMuCgpTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlrbGFz
LnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVjaC5zZT4KLS0tCiBkcml2ZXJzL2RtYS9zaC9yY2Fy
LWRtYWMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9zaC9yY2FyLWRtYWMuYyBiL2RyaXZl
cnMvZG1hL3NoL3JjYXItZG1hYy5jCmluZGV4IDc4MjBkMDcuLjAxY2Y4MmYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZG1hL3NoL3JjYXItZG1hYy5jCisrKyBiL2RyaXZlcnMvZG1hL3NoL3JjYXItZG1h
Yy5jCkBAIC0xNDQsOCArMTQ0LDggQEAgc3RydWN0IHJjYXJfZG1hY19jaGFuIHsKIAogCXVuc2ln
bmVkIGludCBzcmNfeGZlcl9zaXplOwogCXVuc2lnbmVkIGludCBkc3RfeGZlcl9zaXplOwotCWRt
YV9hZGRyX3Qgc3JjX3NsYXZlX2FkZHI7Ci0JZG1hX2FkZHJfdCBkc3Rfc2xhdmVfYWRkcjsKKwlw
aHlzX2FkZHJfdCBzcmNfc2xhdmVfYWRkcjsKKwlwaHlzX2FkZHJfdCBkc3Rfc2xhdmVfYWRkcjsK
IAlpbnQgbWlkX3JpZDsKIAogCXNwaW5sb2NrX3QgbG9jazsKLS0gCjIuNy4yCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=

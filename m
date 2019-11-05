From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Bug 205201 - overflow of DMA mask and bus mask
Date: Tue, 5 Nov 2019 08:56:27 +0100
Message-ID: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
	<84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
	<20181213091021.GA2106@lst.de>
	<835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
	<76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
	<20181213112511.GA4574@lst.de>
	<e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
	<ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
	<e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
	<008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
	<20190103073622.GA24323@lst.de>
	<71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3504ee70-02de-049e-6402-2d530bf55a84-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

SGkgQWxsLAoKV2Ugc3RpbGwgaGF2ZSBETUEgcHJvYmxlbXMgd2l0aCBzb21lIFBDSSBkZXZpY2Vz
LiBTaW5jZSB0aGUgUG93ZXJQQyAKdXBkYXRlcyA0LjIxLTEgWzFdIHdlIG5lZWQgdG8gZGVjcmVh
c2UgdGhlIFJBTSB0byAzNTAwTUIgKG1lbT0zNTAwTSkgaWYgCndlIHdhbnQgdG8gd29yayB3aXRo
IG91ciBQQ0kgZGV2aWNlcy4gVGhlIEZTTCBQNTAyMCBhbmQgUDUwNDAgaGF2ZSB0aGVzZSAKcHJv
YmxlbXMgY3VycmVudGx5LgoKRXJyb3IgbWVzc2FnZToKClvCoMKgIDI1LjY1NDg1Ml0gYnR0diAx
MDAwOjA0OjA1LjA6IG92ZXJmbG93IDB4MDAwMDAwMDBmZTA3NzAwMCs0MDk2IG9mIApETUEgbWFz
ayBmZmZmZmZmZiBidXMgbWFzayBkZjAwMDAwMAoKQWxsIDUueCBMaW51eCBrZXJuZWxzIGNhbid0
IGluaXRpYWxpemUgYSBTQ1NJIFBDSSBjYXJkIGFueW1vcmUgc28gCmJvb3Rpbmcgb2YgYSBMaW51
eCB1c2VybGFuZCBpc24ndCBwb3NzaWJsZS4KClBMRUFTRSBjaGVjayB0aGUgRE1BIGNoYW5nZXMg
aW4gdGhlIFBvd2VyUEMgdXBkYXRlcyA0LjIxLTEgWzFdLiBUaGUgCmtlcm5lbCA0LjIwIHdvcmtz
IHdpdGggYWxsIFBDSSBkZXZpY2VzIHdpdGhvdXQgbGltaXRhdGlvbiBvZiBSQU0uCgpXZSBjcmVh
dGVkIGEgYnVnIHJlcG9ydCBhIG1vbnRoIGFnby4gWzJdCgpUaGFua3MsCkNocmlzdGlhbgoKWzFd
IApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0Lz9pZD04ZDY5NzMzMjdlZTg0YzJmNDBkZDllZmQ4OTI4ZDRhMTE4
NmM5NmUyClsyXSBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIw
NTIwMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==

From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Sat, 8 Dec 2018 14:47:44 +0100
Message-ID: <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
References: <20181129170351.GC27951@lst.de>
	<d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
	<20181130105346.GB26765@lst.de>
	<8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
	<20181130131056.GA5211@lst.de>
	<25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
	<c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
	<58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
	<20181204142426.GA2743@lst.de>
	<ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
	<20181205140550.GA27549@lst.de>
	<1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
	<5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
	<7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
	<8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8a2c4581-0c85-8065-f37e-984755eb31ab-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

TmV4dCBzdGVwOiBlMTVjZDgxNzNlZjg1ZTljYzNlMmE5YzdjYzI5ODJmNWMxMzU1NjE1IChwb3dl
cnBjL2RtYTogZml4IGFuIApvZmYtYnktb25lIGluIGRtYV9jYXBhYmxlKQoKZ2l0IGNoZWNrb3V0
IGUxNWNkODE3M2VmODVlOWNjM2UyYTljN2NjMjk4MmY1YzEzNTU2MTUKClRoZSBQQVNFTUkgb25i
b2FyZCBldGhlcm5ldCBhbHNvIHdvcmtzIHdpdGggdGhpcyBjb21taXQgYW5kIHRoZSBYNTAwMCAK
Ym9vdHMgd2l0aG91dCBhbnkgcHJvYmxlbXMuCgotLSBDaHJpc3RpYW4KCgpPbiAwOCBEZWNlbWJl
ciAyMDE4IGF0IDExOjI5QU0sIENocmlzdGlhbiBaaWdvdHpreSB3cm90ZToKPiBOZXh0IHN0ZXA6
IDdlYmM0NGM1MzVmNmJkNzI2ZDU1Mzc1NmQzOGIxMzdhY2M3MTg0NDMgKHBvd2VycGMvZG1hOiAK
PiByZW1vdmUgbWF4X2RpcmVjdF9kbWFfYWRkcikKPgo+IGdpdCBjaGVja291dCA3ZWJjNDRjNTM1
ZjZiZDcyNmQ1NTM3NTZkMzhiMTM3YWNjNzE4NDQzCj4KPiBPSywgdGhlIFBBU0VNSSBvbmJvYXJk
IGV0aGVybmV0IHdvcmtzIGFuZCB0aGUgUDUwMjAgYm9hcmQgYm9vdHMuCj4KPiAtLSBDaHJpc3Rp
YW4KPgo+Cj4gT24gMDcgRGVjZW1iZXIgMjAxOCBhdCA3OjMzUE0sIENocmlzdGlhbiBaaWdvdHpr
eSB3cm90ZToKPj4gTmV4dCBzdGVwOiAxM2MxZmRlYzU2ODJiNmUxMzI1NzI3N2ZhMTZhYTMxZjM0
MmQxNjdkIChwb3dlcnBjL2RtYTogCj4+IG1vdmUgcGNpX2RtYV9kZXZfc2V0dXBfc3dpb3RsYiB0
byBmc2xfcGNpLmMpCj4+Cj4+IGdpdCBjaGVja291dCAxM2MxZmRlYzU2ODJiNmUxMzI1NzI3N2Zh
MTZhYTMxZjM0MmQxNjdkCj4+Cj4+IFJlc3VsdDogVGhlIFBBU0VNSSBvbmJvYXJkIGV0aGVybmV0
IHdvcmtzIGFuZCB0aGUgUDUwMjAgYm9hcmQgYm9vdHMuCj4+Cj4+IOKAlCBDaHJpc3RpYW4KPgo+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==

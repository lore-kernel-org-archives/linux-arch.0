From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 7 Dec 2018 14:45:06 +0100
Message-ID: <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1948cf84-49ab-543c-472c-d18e27751903-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
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

T24gMDYgRGVjZW1iZXIgMjAxOCBhdCAxMTo1NUFNLCBDaHJpc3RpYW4gWmlnb3R6a3kgd3JvdGU6
Cj4gT24gMDUgRGVjZW1iZXIgMjAxOCBhdCAzOjA1UE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Ogo+Pgo+PiBUaGFua3MuwqAgQ2FuIHlvdSB0cnkgYSBmZXcgc3RlcHBpbmcgcG9pbnRzIGluIHRo
ZSB0cmVlPwo+Pgo+PiBGaXJzdCBqdXN0IHdpdGggY29tbWl0IDdmZDNiYjA1YjczYmVlYTFmOTg0
MGI1MDVhYTA5YmViOWM3NWE4YzYKPj4gKHRoZSBmaXJzdCBvbmUpIGFwcGxpZWQ/Cj4+Cj4+IFNl
Y29uZCB3aXRoIGFsbCBjb21taXRzIHVwIHRvIDVkYTExZTQ5ZGYyMWYyMWRhYzI1YTI0OTFhYTc4
ODMwN2JkYWNiNmIKPj4KPj4gQW5kIGlmIHRoYXQgc3RpbGwgd29ya3Mgd2l0aCBjb21taXRzIHVw
IHRvCj4+IGMxYmZjYWQ0YjBjZjM4Y2U1YjAwZjdhZDg4MGQzYTEzNDg0YzEyM2EKPj4KPiBIaSBD
aHJpc3RvcGgsCj4KPiBJIHVuZGlkIHRoZSBjb21taXQgN2ZkM2JiMDViNzNiZWVhMWY5ODQwYjUw
NWFhMDliZWI5Yzc1YThjNiB3aXRoIHRoZSAKPiBmb2xsb3dpbmcgY29tbWFuZDoKPgo+IGdpdCBj
aGVja291dCA3ZmQzYmIwNWI3M2JlZWExZjk4NDBiNTA1YWEwOWJlYjljNzVhOGM2Cj4KPiBSZXN1
bHQ6IFBBU0VNSSBvbmJvYXJkIGV0aGVybmV0IHdvcmtzIGFnYWluIGFuZCB0aGUgUDUwMjAgYm9h
cmQgYm9vdHMuCj4KPiBJIHdpbGwgdGVzdCB0aGUgb3RoZXIgY29tbWl0cyBpbiB0aGUgbmV4dCBk
YXlzLgo+Cj4gQEFsbAo+IEl0IGlzIHJlYWxseSBpbXBvcnRhbnQsIHRoYXQgeW91IGFsc28gdGVz
dCBDaHJpc3RvcGgncyB3b3JrIG9uIHlvdXIgCj4gUEFTRU1JIGFuZCBOWFAgYm9hcmRzLiBDb3Vs
ZCB5b3UgcGxlYXNlIGhlbHAgdXMgd2l0aCBzb2x2aW5nIHRoZSBpc3N1ZXM/Cj4KPiAnZ2l0IGNs
b25lIGdpdDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2hjaC9taXNjLmdpdCAtYiBwb3dlcnBj
LWRtYS41IGEnCj4KPiBUaGFua3MsCj4gQ2hyaXN0aWFuCj4KPgpUb2RheSBJIHRlc3RlZCB0aGUg
Y29tbWl0IDVkYTExZTQ5ZGYyMWYyMWRhYzI1YTI0OTFhYTc4ODMwN2JkYWNiNmIuCgpnaXQgY2hl
Y2tvdXQgNWRhMTFlNDlkZjIxZjIxZGFjMjVhMjQ5MWFhNzg4MzA3YmRhY2I2YgoKVGhlIFBBU0VN
SSBvbmJvYXJkIGV0aGVybmV0IHdvcmtzIGFuZCB0aGUgUDUwMjAgYm9hcmQgYm9vdHMuCgotLSBD
aHJpc3RpYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==

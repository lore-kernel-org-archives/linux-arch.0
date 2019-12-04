From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
Date: Wed, 4 Dec 2019 13:22:01 +0100
Message-ID: <1D79E674-5A47-4268-AA96-DA02E8A51929@xenosoft.de>
References: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
 <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
 <20191126164026.GA8026@lst.de> <20191127065624.GB16913@linux.ibm.com>
 <20191204085634.GA25929@lst.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20191204085634.GA25929-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org, rtd2-kGM0oXzJM5p02iOg2JU2CQ@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, mad skateman <madskateman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org" <contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org
List-Id: linux-arch.vger.kernel.org

SSB0aGluayB3ZSBoYXZlIHRvIHdhaXQgdG8gUm9sYW5k4oCZcyB0ZXN0IHJlc3VsdHMgd2l0aCBo
aXMgU0NTSSBQQ0kgY2FyZC4KCkNocmlzdGlhbgoKU2VudCBmcm9tIG15IGlQaG9uZQoKPiBPbiA0
LiBEZWMgMjAxOSwgYXQgMDk6NTYsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90
ZToKPiAKPj4gT24gV2VkLCBOb3YgMjcsIDIwMTkgYXQgMDg6NTY6MjVBTSArMDIwMCwgTWlrZSBS
YXBvcG9ydCB3cm90ZToKPj4+IE9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0IDA1OjQwOjI2UE0gKzAx
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+Pj4+IE9uIFR1ZSwgTm92IDI2LCAyMDE5IGF0
IDEyOjI2OjM4UE0gKzAxMDAsIENocmlzdGlhbiBaaWdvdHpreSB3cm90ZToKPj4+PiBIZWxsbyBD
aHJpc3RvcGgsCj4+Pj4gCj4+Pj4gVGhlIFBDSSBUViBjYXJkIHdvcmtzIHdpdGggeW91ciBwYXRj
aCEgSSB3YXMgYWJsZSB0byBwYXRjaCB5b3VyIEdpdCBrZXJuZWwgCj4+Pj4gd2l0aCB0aGUgcGF0
Y2ggYWJvdmUuCj4+Pj4gCj4+Pj4gSSBoYXZlbid0IGZvdW5kIGFueSBlcnJvciBtZXNzYWdlcyBp
biB0aGUgZG1lc2cgeWV0Lgo+Pj4gCj4+PiBUaGFua3MuICBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMg
YSBiaXQgb2YgYSBoYWNrIGFzIHdlIG5lZWQgdG8gc2V0Cj4+PiB0aGUgbWFzayBiYXNlZCBvbiBy
dW50aW1lIGluZm9ybWF0aW9uIGxpa2UgdGhlIG1hZ2ljIEZTTCBQQ0llIHdpbmRvdy4KPj4+IExl
dCBtZSB0cnkgdG8gZHJhZnQgc29tZXRoaW5nIGJldHRlciB1cCwgYW5kIHRoYW5rcyBhbHJlYWR5
IGZvciB0ZXN0aW5nCj4+PiB0aGlzIG9uZSEKPj4gCj4+IE1heWJlIHdlJ2xsIHNpbXBseSBmb3Jj
ZSBib3R0b20gdXAgYWxsb2NhdGlvbiBiZWZvcmUgY2FsbGluZwo+PiBzd2lvdGxiX2luaXQoKT8g
QW55d2F5LCBpdCdzIHRoZSBsYXN0IG1lbWJsb2NrIGFsbG9jYXRpb24uCj4gCj4gU28gSSB0aGlu
ayB3ZSBzaG91bGQgZ28gd2l0aCB0aGlzIGZpeCAocGx1cyBhIHNvdXJjZSBjb2RlIGNvbW1lbnQp
IGZvcgo+IG5vdy4gIFJldmFtcGluZyB0aGUgd2hvbGUgbWVtb3J5IGluaXRpYWxpemF0aW9uIGlz
IGdvaW5nIHRvIHRha2UgYQo+IHdoaWxlLCBhbmQgdGhpcyBmaXggYWxzbyBpcyBlYXNpbHkgYmFj
a3BvcnRhYmxlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=

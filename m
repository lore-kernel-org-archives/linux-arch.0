From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Date: Mon, 13 Aug 2018 17:39:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08C903@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08C82C@us01wembx1.internal.synopsys.com>
 <1534181238.3962.74.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>"Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On 08/13/2018 10:27 AM, Eugeniy Paltsev wrote:=0A=
>> You didn't pay attention to my previous comment on this !=0A=
>> IOC port can be considered a micro-architecture optimization (an importa=
nt one=0A=
>> though). The main thing is hardware snooping DMA transactions which enab=
led IOC in=0A=
>> first place.=0A=
> Ok, I'll rewrite this commit message.=0A=
=0A=
No need since this is a cover letter and will get dropped anyways, but the =
reason=0A=
I emphasize it is that it sets the wrong expectations for someone down the =
line=0A=
googling for this stuff ! And that someone could be other or just us when w=
e've=0A=
long forgotten about this ;-)=0A=
=0A=
>=0A=
>>> Some recent SoC with ARC HS (like HSDK) allow to select bus=0A=
>>> port (IOC or non-IOC port) for connecting DMA devices in runtime.=0A=
>> Again you mention the port but none of your 4 patches actually touch the=
 port=0A=
>> itself in programming it.=0A=
> Ok.=0A=
>=0A=
=0A=

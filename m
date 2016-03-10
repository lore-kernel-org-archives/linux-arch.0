From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 05:19:37 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8EE1D@us01wembx1.internal.synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Noam Camus <noamc@ezchip.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 10 March 2016 10:35 AM, Vineet Gupta wrote:
> +CC Noam
>
> On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
>> > Memory access primitives should use cpu_to_le16, cpu_to_le32, le16_to_cpu
>> > and le32_to_cpu because it is not really guaranteed that drivers handles
>> > any ordering themselves.
> That is the driver issue. readxx as API simply returns data in native endianness.
> We've had EZChip running big endian and so far and they didn't need this change.
>
>> > For example, serial port driver doesn't work when kernel is build for
>> > arc big endian architecture.
> Last I tested Big Endian on SDP with 8250 part + 8250 driver it was working fine.
> I presume this is the systemC model for device and standard 8250 driver and very
> likely the model is not fixed endian or something.
>
> Alexey knows about this stuff - this was discussed on lkml back in 2013 when he
> was fighting the Xilinx systemAce driver endian issues
>

Do you need "native-endian" DT entry in nsimosci DT bindings for uart ?

From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 10/17] irqchip: New RISC-V PLIC Driver
Date: Mon, 26 Jun 2017 18:09:28 -0700 (PDT)
Message-ID: <mhng-d46bc90a-140d-4c57-801a-ebd334077b4d@palmer-si-x1c4>
References: <20170609134748.GL13955@arm.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35499 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdF0BJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 21:09:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so2229560pgc.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2017 18:09:29 -0700 (PDT)
In-Reply-To: <20170609134748.GL13955@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: marc.zyngier@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, peterz@infradead.org

On Fri, 09 Jun 2017 06:47:48 PDT (-0700), will.deacon@arm.com wrote:
> On Wed, Jun 07, 2017 at 11:52:10AM +0100, Marc Zyngier wrote:
>> On 07/06/17 00:00, Palmer Dabbelt wrote:
>> > +static void plic_disable(struct plic_data *data, int i, int hwirq)
>> > +{
>> > +	struct plic_enable_context *enable = plic_enable_context(data, i);
>> > +
>> > +	atomic_and(~(1 << (hwirq % 32)), &enable->mask[hwirq / 32]);
>>
>> This is still a device access, right? What does it mean to use the
>> atomic primitives on that? What are you racing against? I thought the
>> various context were private to an execution context...
>>
>> Adding Will and PeterZ to the CC list because they will probably have
>> their own views on this...
>
> atomic_* accesses to MMIO is almost certainly a bad idea. Is this atomic
> because you want to allow the function to run concurrently, or is it atomic
> because you want some guarantees from the endpoint's view?

Concurrency: while most operations on the PLIC are per-hart, in order to
disable an interrupt you have to go clear a bit for every hart.  The AMO ensure
the read-modify-write cycle didn't drop some other hart disabling a different
interrupt (as the bits are all in the same word).

I've done a big cleanup on this driver to avoid memory-mapped structures, use a
lock instead of AMOs, and use the FastEOI flow.  I'm getting close to getting
through all the code reviews for my v2 RISC-V patch set (which included this,
our arch support, and all our other driver patches).  I'm going to split out
the drivers for the next patch set, as it appears that's the better way to do
it.

Hopefully I can get the cleaned up patches out tonight.

Thanks!

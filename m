From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 08/60] microblaze_v4: exception handling
Date: Thu, 26 Jun 2008 21:19:53 +0200
Message-ID: <4863EBD9.1010601@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>	 <1214483429-32360-2-git-send-email-monstr@seznam.cz>	 <1214483429-32360-3-git-send-email-monstr@seznam.cz>	 <1214483429-32360-4-git-send-email-monstr@seznam.cz>	 <1214483429-32360-5-git-send-email-monstr@seznam.cz>	 <1214483429-32360-6-git-send-email-monstr@seznam.cz>	 <1214483429-32360-7-git-send-email-monstr@seznam.cz>	 <1214483429-32360-8-git-send-email-monstr@seznam.cz>	 <1214483429-32360-9-git-send-email-monstr@seznam.cz> <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757225AbYFZTT1@vger.kernel.org>
In-Reply-To: <2c0942db0806260935p51564a7et6517b39e9a6706dc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org




> On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
>> +ex_sw:
>> +       /* Get the destination register number into r5 */
>> +       lbui    r5, r0, ex_reg_op;
>> +       /* Form store_word jump table offset (sw_table + (8 * regnum)) */
>> +       la      r6, r0, sw_table;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r5;
>> +       add     r5, r5, r6;
>> +       bra     r5;
> 
> Possibly stupid question: This is part of the unaligned store word
> exception handler, yes? Shouldn't the above add's be addk's to
> preserve the state of the carry register pre/post store?

I don't think that addk is important. I have some tests for exception, I want to
cover full exception handling.

M

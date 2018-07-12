Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:45069 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeGLQOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jul 2018 12:14:32 -0400
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <27030.1531302693@warthog.procyon.org.uk> <20180712125152.GA5226@guoren>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
Date: Thu, 12 Jul 2018 10:04:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180712125152.GA5226@guoren>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>, David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180712160410.neMzBpyY5Ut5Y24Pb0RRPFEzU5uOg9f0l_kGlNac4Es@z>

On 07/12/2018 06:51 AM, Guo Ren wrote:
> On Wed, Jul 11, 2018 at 10:51:33AM +0100, David Howells wrote:
>> Can you say what the --target tuple should be so that I can add the arch to my
>> collection of Fedora cross-binutils and cross-gcc tools built from upstream
>> binutils and gcc sources?
> Metor Graghics are helping us upstream gcc and binutils.
> 
> @Sandra,
> 
> Could you help me to reply the question?

Neither binutils nor gcc support for C-SKY are in the upstream 
repositories yet.  We should be resubmitting the binutils port soon 
(with bug fixes to address the test failures that caused it to be 
rejected the last time), and the gcc port will follow that shortly.

The target triplets we have been testing are csky-elf, csky-linux-gnu, 
and csky-linux-uclibc.  Note that the gcc port will only support v2 
processors/ABI so that is the default ABI for these triplets.

I'm not familiar with the Fedora tools, but to build a complete 
toolchain you'll need library support as well and I'm not sure what the 
submission status/plans for that are.  E.g. Mentor did a newlib/libgloss 
port for local testing of the ELF toolchain and provided it to C-SKY, 
but pushing that to the upstream repository ourselves is not on our todo 
list.

-Sandra

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45847 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387902AbeGMBmi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jul 2018 21:42:38 -0400
Date: Fri, 13 Jul 2018 09:30:13 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
Message-ID: <20180713013013.GA25852@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <27030.1531302693@warthog.procyon.org.uk>
 <20180712125152.GA5226@guoren>
 <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180713013013.nWb4WG14pw_EvySvq0weiCxnj4wGEbDcZlywbxiIX_Y@z>

On Thu, Jul 12, 2018 at 10:04:10AM -0600, Sandra Loosemore wrote:
> On 07/12/2018 06:51 AM, Guo Ren wrote:
> >On Wed, Jul 11, 2018 at 10:51:33AM +0100, David Howells wrote:
> >>Can you say what the --target tuple should be so that I can add the arch to my
> >>collection of Fedora cross-binutils and cross-gcc tools built from upstream
> >>binutils and gcc sources?
> >Metor Graghics are helping us upstream gcc and binutils.
> >
> >@Sandra,
> >
> >Could you help me to reply the question?
> 
> Neither binutils nor gcc support for C-SKY are in the upstream repositories
> yet.  We should be resubmitting the binutils port soon (with bug fixes to
> address the test failures that caused it to be rejected the last time), and
> the gcc port will follow that shortly.
> 
> The target triplets we have been testing are csky-elf, csky-linux-gnu, and
> csky-linux-uclibc.  Note that the gcc port will only support v2
> processors/ABI so that is the default ABI for these triplets.
> 
> I'm not familiar with the Fedora tools, but to build a complete toolchain
> you'll need library support as well and I'm not sure what the submission
> status/plans for that are.  E.g. Mentor did a newlib/libgloss port for local
> testing of the ELF toolchain and provided it to C-SKY, but pushing that to
> the upstream repository ourselves is not on our todo list.
> 
> -Sandra

Thank you, Sandra.

 Guo Ren

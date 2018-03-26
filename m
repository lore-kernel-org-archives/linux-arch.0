Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:47718 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeCZPGi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2018 11:06:38 -0400
Subject: Re: [gnu-csky] [PATCH 00/19] C-SKY(csky) Linux Kernel Port
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <8f76538a-27a4-745e-3d28-db3be06e9715@codesourcery.com>
Date: Mon, 26 Mar 2018 09:06:26 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, wbx@uclibc-ng.org, thomas.petazzoni@bootlin.com, gnu-csky@mentor.com, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180326150626.Wvi4cNWII7hTWfiqzciEYCISpnMr_2BnvNadIU-5Mxg@z>

On 03/26/2018 07:30 AM, Arnd Bergmann wrote:
> 
> Another interesting question is the status of your toolchain support. I see your
> github account contains binutils and gcc repositories, but they are not upstream
> yet. Are you working on getting those included in the respective upstream
> projects already?

We at Mentor Graphics are working on preparing the abiv2 binutils and 
gcc support for upstream submission.  The existing gcc back end for 
abiv1 is actually completely separate from the abiv2 back end and 
probably eventually needs to be merged with it, but first things first.

-Sandra

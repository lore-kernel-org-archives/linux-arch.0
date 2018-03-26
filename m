From: Sandra Loosemore <sandra@codesourcery.com>
Subject: Re: [gnu-csky] [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Date: Mon, 26 Mar 2018 09:06:26 -0600
Message-ID: <8f76538a-27a4-745e-3d28-db3be06e9715@codesourcery.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3KwvNpYUXG-CqfF7V0GQ3sv_CoPmajq_+06aqkLiUFXw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, wbx@uclibc-ng.org, thomas.petazzoni@bootlin.com, gnu-csky@mentor.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

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

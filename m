From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH, re-send] Always trap on BUG()
Date: Fri, 26 Jul 2013 09:05:17 +0800
Message-ID: <51F1CB4D.2020301@asianux.com>
References: <201307051738.35930.arnd@arndb.de> <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org> <20130715222755.GY24642@n2100.arm.linux.org.uk> <51E47924.9030005@zytor.com> <20130723093628.GC19786@gmail.com> <51EF1936.7090801@asianux.com> <20130725220502.GI18254@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130725220502.GI18254@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On 07/26/2013 06:05 AM, Ingo Molnar wrote:
> * Chen Gang <gang.chen@asianux.com> wrote:
> 
>> On 07/23/2013 05:36 PM, Ingo Molnar wrote:
>>>
>>> (the crazies can keep a separate patch to remove even more of BUG() to win 
>>> a K or two.)
>>>
>>
>> Excuse me, my English is not quite well, I do not quite understand your
>> meaning, could you please repeat again in details or say more clearly ?
> 
> I meant: those people who'd like to have the tiny 
> additional space savings offered by !CONFIG_BUG (and are 
> crazy enough to live with non-determinism in exchange for a 
> measly payment of 1 KB), can apply a separate, out of tree 
> patch just fine and don't need upstream kernel support.
> 

Thank you for your reply in details.


Thanks
-- 
Chen Gang

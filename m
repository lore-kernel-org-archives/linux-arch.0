From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: sparc: kernel: check the memory length before use
 strcpy().
Date: Thu, 11 Jul 2013 07:41:22 +0800
Message-ID: <51DDF122.9040206@asianux.com>
References: <51C53571.9070403@asianux.com> <20130710.134216.1407498845215548973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20130710.134216.1407498845215548973.davem@davemloft.net>
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sam@ravnborg.org, zhaohongjiang@huawei.com, gregkh@linuxfoundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 07/11/2013 04:42 AM, David Miller wrote:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Sat, 22 Jun 2013 13:26:09 +0800
> 
>> > 
>> > For the related next strcpy(), the destination length is less than 512,
>> > but the source maximize length may be 'OPROMMAXPARAM' (4096) which is
>> > more than 512.
>> > 
>> > One work flow may:
>> >   openprom_sunos_ioctl() ->  if (cmd == OPROMSETOPT)
>> >     getstrings() ->  will alloc buffer with size 'OPROMMAXPARAM'.
>> >     opromsetopt() ->  devide the buffer into 'var' and 'value'
>> >       of_set_property() -> pass
>> >         prom_setprop() -> pass
>> >           ldom_set_var()
>> > 
>> > And do not mind the additional 4 alignment buffer increasing, since
>> > 'sizeof(pkt) - sizeof(pkt.header)' is 4 alignment at least.
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Applied.
> 
> 

Thank you for your work, especially you are very busy.

-- 
Chen Gang

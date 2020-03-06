From: Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Date: Fri, 6 Mar 2020 13:07:35 +0100
Message-ID: <fded1845-98db-f0fb-9320-842c9fdc30dc@vivier.eu>
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
 <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
 <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
 <87v9nhzp6w.fsf@mid.deneb.enyo.de>
 <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: fr
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YunQiang Su <syq-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Florian Weimer <fw-d32yF4oPJVt0XxTmqZlbVQ@public.gmane.org>
Cc: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libc-alpha-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Le 06/03/2020 à 12:48, YunQiang Su a écrit :
> Florian Weimer <fw-d32yF4oPJVt0XxTmqZlbVQ@public.gmane.org> 于2020年3月6日周五 下午7:42写道：
>>
>> * YunQiang Su:
>>
>>> AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
>>>    /* AT_* values 18 through 22 are reserved */
>>>    27,28,29,30 are not used now.
>>> Which should we use?
>>
>> Where does this limit of 32 tags come from?  I don't see it from a
>> userspace perspective.
> 
> Sorry it is my mistake: In linux/auxvec.h, I saw
> 
> #define AT_RANDOM 25    /* address of 16 random bytes */
> #define AT_HWCAP2 26    /* extension of AT_HWCAP */
> 
> #define AT_EXECFN  31   /* filename of program */
> 
> The number jump to 31 from 26.
> 
> It is my fault: in x86_64-linux-gnu/bits/auxv.h, the max number is 47 now.
> 

Numbers starting from 32 are arch specific.
18 to 22 are also reserved (and used by some archs).
(linux/arch/*/include/uapi/asm/auxvec.h)

So there is only 4 entries available (27 to 30)
(linux/include/uapi/linux/auxvec.h)
Do we want to waste one more entry whereas we can use an unused one?

Thanks,
Laurent

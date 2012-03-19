From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 13/35] Disintegrate asm/system.h for M68K [ver #2]
Date: Mon, 19 Mar 2012 21:48:22 +1000
Message-ID: <4F671D06.2010700@snapgear.com>
References: <4F6698C1.3070105@snapgear.com> <4F608A15.9030609@snapgear.com> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233816.13888.142.stgit@warthog.procyon.org.uk> <17434.1331905343@redhat.com> <4774.1332154141@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <4774.1332154141@redhat.com>
Sender: linux-m68k-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-m68k@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi David,

On 03/19/2012 08:49 PM, David Howells wrote:
> Greg Ungerer<gerg@snapgear.com>  wrote:
>
>>> How about if I insert the attached patch prior?
>>
>> Yep, that fixes it. Builds on its own, and with the asm/system.h
>> disintegration patch applied (and rejects fixed) as well.
>
> Can I add your Acked-by to them?

Yep, absolutely.

Acked-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com

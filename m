From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
Date: Mon, 21 Nov 2011 10:51:06 -0800
Message-ID: <4ECA9D9A.5040006@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-2-git-send-email-ddaney.cavm@gmail.com> <4EC98C97.50604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EC98C97.50604@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, x86@kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-arch.vger.kernel.org

On 11/20/2011 03:26 PM, H. Peter Anvin wrote:
> On 11/18/2011 11:37 AM, David Daney wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> Using this build-time sort saves time booting as we don't have to burn
>> cycles sorting the exception table.
>>
>
> If we're going to do this at build time, I would suggest using a
> collisionless hash instead.  The lookup time for those are O(1), but
> they definitely need to be done at build time.
>

It is my understanding that such a hash table would be sparsely 
populated, so space would have to be reserved for the empty buckets. 
The current patch, which works in-place on the fully linked vmlinux, 
doesn't have to worry about finding enough space for the table.

If we were to do the collisionless hash, we would somehow have to 
reserve space for the empty buckets.

On my test kernel, there were only 1453 entries in the exception table, 
So doing the binary search takes a maximum of 11 loads.

So, I guess I am not strongly opposed to using a collisionless hash, but 
I think it may not be worth the extra effort.

David Daney

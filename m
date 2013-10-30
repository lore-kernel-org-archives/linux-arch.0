From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: use ASM_NL instead of ';' for assembler new line
 character in the macro
Date: Wed, 30 Oct 2013 08:57:11 +0800
Message-ID: <52705967.1060603@asianux.com>
References: <526FA1B7.4090808@asianux.com> <526F09B8.9030202@asianux.com> <526E3CE2.2070405@asianux.com> <526E6A92.6090301@synopsys.com> <24899.1383043169@warthog.procyon.org.uk> <26752.1383055147@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:10903 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab3J3A6R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2013 20:58:17 -0400
In-Reply-To: <26752.1383055147@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Vineet Gupta <vineetg76@gmail.com>, James Hogan <james.hogan@imgtec.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>

On 10/29/2013 09:59 PM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>>>>> For "kernel/modsign_certificate.S", I recommend to expand the macro
>>>>> which will shrink code line, either need not include additional header
>>>>> file, I feel that will be simpler for both code reader and writers.
>>> I recommend leaving that file alone.  That gets moved to a .S file in patches
>>> queued in the security tree.
>>
>> Excuse me, I am not quite familiar with our version merging, I guess
>> your meaning is "this file will be removed, and the related contents
>> will be in another .S file, so we need not fix it within this file".
>>
>> If what I guess is correct, I support your recommendation (and if what I
>> guess is incorrect, please let me know, thanks). :-)
> 
> Sorry, I misread what you were saying.  The code has already been split out of
> the .c file of course (I'd forgotten that it had).  In the security tree next
> branch, the .S file gets renamed and slightly modified here:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/jmorris/linux-security.git/commit/?h=next&id=b56e5a17b6b9acd16997960504b9940d0d7984e7
> 

Oh, thank you for your information, and I will send patch v3 for it.

I need/should based on another next-tree branch, and use its tag
"next-20131025" to continue (which already contents original related
changes).

And also, excuse me, my English is not quite well (which easily lead
other members misunderstanding).


Thanks.
-- 
Chen Gang

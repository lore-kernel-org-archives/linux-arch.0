Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB843D7D7F;
	Mon,  1 Jun 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326431; cv=none; b=IhjiVsgW85+M2k8oK5qthM4SIC2xlOKsF2LZGXxiiD/A6OzkmCceObgFH83e7E+mLX5HiWptBsRtyfaL9aKHUapqI8imOMCItZgYx7NZREv4nXQwHffK3mYJB9iOorwzdGRCrSFMfAUbez7BmdIQNOIxl5RhmAGQIkTtozREdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326431; c=relaxed/simple;
	bh=l24A4xtSXmCG4cWpWE26kMbivFR6YG8PmPI2QvPnYA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEnC8FtEnuVXNOzii2lVZwvJAlXyg/TNrZal7hHNp9FSnRKxvim13rqCwdoe0akRj3grs7E+tF80BChQ1NZeg33ms9PnC5l2r3jXXyCVML9thLKjB8+gDY/PicZauhy9VVw8nUJVmoenjQ00FzdbVig/yHc7YRAOXRmE2mYAYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLLNx4tr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLLNx4tr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF021F00893;
	Mon,  1 Jun 2026 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326429;
	bh=4fyrYnBMknGZNZvrg4Jkv5tJrVT1PYSgZLWdGZo8E8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GLLNx4trRl8BW+neKsDlqwr/7K2a3JfqfT6qqpsrw1JKVrCNklaDyGpn7PxankWcl
	 Tj/rbcPSGdZ3/KPlAGxFQ6phAPnKDg2d+bPMLZ0PlNE9QNt0CmLF10qmYB8QRdbnb0
	 dVxfgKuk4/RJ/o4UKn3lLc9Z40JPYh2tlQamcXwmUECXMii0YysZI23JCj0+4LcckI
	 h5u9qOpub1iAhZwqu1LwY6Py7f7OO3/ON1Mnw5AB8Ur6Xk4LnPRAYneclKkRJ56NsF
	 kp5DRs8ABecaCkS9FS9LxKykevvXjqJTcsabvyc6hZAgyWwHotAXomHwYlCbNoLmuh
	 q1MWATAN5LXww==
Message-ID: <52287c46-aba8-4247-9939-4994bd57c4bd@kernel.org>
Date: Mon, 1 Jun 2026 17:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [arch?] BUG: sleeping function called from invalid
 context in __tlb_batch_free_encoded_pages
To: Will Deacon <will@kernel.org>,
 syzbot <syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, qi.zheng@linux.dev
References: <69f302ff.170a0220.3c4978.0016.GAE@google.com>
 <ahbd7_KaUn45GK3v@willie-the-truck>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ahbd7_KaUn45GK3v@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 14:05, Will Deacon wrote:
> I finally got a chance to look at this one...
> 
> On Thu, Apr 30, 2026 at 12:21:35AM -0700, syzbot wrote:
>> syzbot found the following issue on:
>>
>> HEAD commit:    dca922e019dd Merge tag 'xsa48x-7.1-tag' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11cd6b6c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a169a27b0538ba43e5d3
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dca922e0.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/7b447b1b93a9/vmlinux-dca922e0.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/af7830f5dabf/bzImage-dca922e0.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com
>>
>> BUG: sleeping function called from invalid context at mm/mmu_gather.c:142
>> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5677, name: rm
>> preempt_count: 0, expected: 0
>> RCU nest depth: 1, expected: 0
>> 2 locks held by rm/5677:
>>  #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:536 [inline]
>>  #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x22c/0xa10 mm/mmap.c:1308
>>  #1: ffffffff8e7e54e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 include/linux/rcupdate.h:300
>> CPU: 1 UID: 0 PID: 5677 Comm: rm Not tainted syzkaller #0 PREEMPT(full) 
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>>  __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
>>  __tlb_batch_free_encoded_pages+0x11e/0x280 mm/mmu_gather.c:142
>>  tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
> 
> ... so we're getting deep in the gather code tearing down an mm, where
> we free the unmapped pages but we're somehow inside an RCU read-side
> critical section.
> 
> The last report on the sysbot dashboard is from 30th April, which
> coincides with 99ebc509eef5 ("mm: memcontrol: fix rcu unbalance in
> get_non_dying_memcg_end()") landing upstream. Unfortunately, there's no
> reproducer available to test that concretely but it looks like we can
> end up in there via the page freeing path. So hopefully this is fixed.

Yes, sounds reasonable.

-- 
Cheers,

David

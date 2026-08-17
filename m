Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00E41D111;
	Mon, 17 Aug 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978570; cv=none; b=OlyaXlk5VPvfq5fhfsiaEO/yt95IsupzM8R8TJDjg9OEDVoV1yz17Ks66N0+UMslS+uooquNl6Ad38d4kBbxNywDb5zVrLOHCfsRjFFsza8uXsp1hbDy3tb3MLijT+MdYG3XBAAB9iErWh+5dSvAnJPhDkty7FZxRmvTBx9OQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978570; c=relaxed/simple;
	bh=zKihgbS5nDS06cQzE66st0SGecyEu223mvzJ1W2fmjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp1rpHKhYxvBaQ2fgPUSUbKrOJol759CVuUVtgrEVYwvU/FFElwjNJFcW/Ne181hlGAfKlJDa6PsU+xge4gNb8DRuWFziKK1bnmBP1m5SrCqe5RK2tjxEaWk0JiD2hW15YrdK96Aqf+S3zCjhajDV+meOU7s5Zn9iKJ/sN8LjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BWxYuH5s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BWxYuH5s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dnZFmDXrDqKiOQ0R5xHMapP9fk9uZVdNfkWYA/sBhZw=; b=BWxYuH5sa3c7WBtYwENft5x9Mm
	LEZalcCHlhiT+7fo/6Auo/Jo7UAdynfFE1i08Ite0B2GuTX1pHrKmEYSh9RFmKGK8268G7vDWw7kH
	boc4tjVnO/PepXoyDw97ph0DwVLuFIc2U6XKm6D6wbQkg+YCCIlIr8N9Ph4bGJqzEqQzunmTBeUHM
	KhdgAtUn6e3NmygCJCImW8JaM90WjxlULa/avigvw7vlafNDVu+daIpAg4Z2tGih1kcIDmVJbY+Ef
	5Ac4GbSfkhcRY/d9hJAv2JRbEfU3+8DInYFbQgutXM7TLyxG1EH1fwlJkyu15dQWnLlKar0Rycx7G
	u079AVTA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvykw-00000006Lpd-0Vwf;
	Mon, 17 Aug 2026 14:56:06 +0000
Message-ID: <86cea3c6-78f4-4489-bddf-a03987dce362@infradead.org>
Date: Mon, 17 Aug 2026 07:56:05 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Test: Added self-testing and documentation
To: Mathura kumar <mathura.kumar.tech@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, corbet@lwn.net
References: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
 <20260816153811.1085261-5-mathura.kumar.tech@gmail.com>
 <61e9bf07-78b5-4696-b467-4c0ff462fe75@infradead.org>
 <CABSt=QTZPCWgwKfNgV4o0fq_qjMs19binm74eX8GApsKs7R09Q@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABSt=QTZPCWgwKfNgV4o0fq_qjMs19binm74eX8GApsKs7R09Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/17/26 5:37 AM, Mathura kumar wrote:
> yeah, I have fixed the minor formatting and one unsequenced new sys
> number for microblaze in syscall.tbl
> Should I wait for a complete review for this or send an updated version,
> and one more thing sashiko show potential regression in core
> augmentation logic but i think it is false positive and i am pretty
> sure, as per my intuition i don't think it have any regression
> regrading propagating msg count after insertion and deletion of node.
> 

I'd say wait for more comments/review.

> Thanks,
> Mathura
> 
> 
> On Sun, Aug 16, 2026 at 9:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi--
>>
>> On 8/16/26 8:34 AM, mathura kumar wrote:
>>> Add test coverage to verify system call behavior under
>>> different-different cases.
>>>
>>> Update index documentation to include two new doc.
>>>       1) mq_recvmmsg.rst
>>>       2) mq_sendmmsg.rst
>>>
>>> The tests validate:
>>>       1) Offset boundries.
>>>       2) Partial success behaviors.
>>>       3) Timeout behavior.
>>>
>>> Documentation changes include:
>>>       1) Updated implementation details.
>>>       2) Error handlings mechanism.
>>>       3) Tests details.
>>>
>>> Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
>>> ---
>>>  Documentation/userspace-api/index.rst       |   2 +
>>>  Documentation/userspace-api/mq_recvmmsg.rst | 205 ++++++++++
>>>  Documentation/userspace-api/mq_sendmmsg.rst | 168 +++++++++
>>>  tools/testing/selftests/ipc/Makefile        |   2 +-
>>>  tools/testing/selftests/ipc/mq_recvmmsg.c   | 392 ++++++++++++++++++++
>>>  tools/testing/selftests/ipc/mq_sendmmsg.c   | 360 ++++++++++++++++++
>>>  6 files changed, 1128 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
>>>  create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
>>>  create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
>>>  create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c
>>
>> Documentation build warnings (from 'make htmldocs'):
>>
>> Documentation/userspace-api/mq_recvmmsg.rst:96: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
>> /work/lnx/repo/linux-next/Documentation/userspace-api/mq_recvmmsg.rst:179: WARNING: Title underline too short.
>>
>> 3.4 start_idx argument
>> ~~~~~~~~~~~~~~~~~~~ [docutils]
>> Documentation/userspace-api/mq_sendmmsg.rst:77: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
>> /work/lnx/repo/linux-next/Documentation/userspace-api/mq_sendmmsg.rst:146: WARNING: Title underline too short.
>>
>> 3.3 start_idx argument
>> ~~~~~~~~~~~~~~~~~~~ [docutils]
>>
>>
>> --
>> ~Randy
>>

-- 
~Randy


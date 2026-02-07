Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209D2745C;
	Sat,  7 Feb 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431681; cv=none; b=pBQuxDQByMoqZUrVSPjgO+j8QyQkE/ST4iLVAnGE0TSgNbNk0cWXTr2UL+B212o1aJPZtGwxmyo7KoRhrBVVBsFFLBSDkRFHk7bnZ8IuBz54nU/80+q3+Ct7+HQM+2tYmiGMeOGADxbuVrKkqdv1FrzFSevhOMDdJ1iXrSeMdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431681; c=relaxed/simple;
	bh=BqvKzVJY30xIUrq9dBZ2tM2GYhuP9H2OnwHwYd2FWto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9aue0Ts4FEfERMkRmdnzN1xSu7VrD5n8XfGrdC0se7khoVy6mawxhC/MogeedD4ynWOEeX0Lf5p+W/8DFZtjU4yGC+i+kFZNCO+SBfu2oe4dtERD4+p66WOW2/15Z5ds+q8CKaqVEZj3q+KMceA11ZEsV9tiCE5jA20uslYi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=N5T//0aB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="N5T//0aB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770431663; x=1771036463; i=deller@gmx.de;
	bh=iqG3n+AtWmSErPoMkbx3xS56hQrrCJzxK6+YGnEoZt4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N5T//0aB4sdj+dl5sWptERrSOKcrsJppeuBwezXzKg81D2YY9Fhaowuih48Q/7Qi
	 /1LbsVJCjQItzhF/ts+9l5Q7RebcHtiyTbkLkEDKhbfLvo5oSUD+ZhGw5vBuG4ILx
	 F0kjuCPpTnEYYx567dqk/oYU35v2AzUosDG5tO1i1iOLEqYiohT6l7NYtfX5gUxdJ
	 Sd3waj+w/30Sz1RR8EtrSbklkIZ5pO6G4KMiceQc38iYh/mDL1M/5h382X/jCBFxa
	 2YLBQbGUjHAYxIgn9ktS5CnUCvfZaaQ2HuyH9mU28eUZ2p4YvNq2Z/zg2v8EnHNN7
	 pY0bgqDoVT8c7/RYhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Ed-1vh1k23D3N-00ryvU; Sat, 07
 Feb 2026 03:34:23 +0100
Message-ID: <7e31fe0b-c321-4f09-9d7a-19d22851129c@gmx.de>
Date: Sat, 7 Feb 2026 03:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] parisc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-parisc@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <b827939046dbc94bc7c585cdbed8522baab75b15.1769515122.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b827939046dbc94bc7c585cdbed8522baab75b15.1769515122.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CkDflEPh0GVIBynaJ9UUtHGd5nScmkVj7b6zKyWDtJVjsvwrjDJ
 v5pcJvzyEp1kr99WWgLnuM5aQycXyN78izpSm4theQ/jK6akBcDPlYimDBBJHtnEIUC4lKh
 Am2jpNhfqeO0d1AUmR0+eEzXyUIeIrgItBnI9FVOTYhEVJqxgw8oltpiL9ZVHqzM4k9r5y2
 VUkwkE1HFbLSfMvqGDnQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6cCBE9kDVxI=;wreWLAfwauUstLuyb+7/TQld0+P
 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

On 1/27/26 13:12, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> ---
>   arch/parisc/Kconfig           | 1 +
>   arch/parisc/include/asm/tlb.h | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Helge Deller <deller@gmx.de>   # parisc
Tested-by: Helge Deller <deller@gmx.de>  # parisc

Thanks!
Helge

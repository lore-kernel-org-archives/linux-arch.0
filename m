Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CA3AA1AE;
	Fri,  4 Sep 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556787; cv=none; b=SpAyM6DLZUwAzJl9qXeA4Mhb1T+pFVe2CSegW9gqj06lYGBbaTbuLULnI+tSCqp2kLkytbyGvSZUW57BGgceNd2gRXEFgMCjUb4C9ojacYmcWH7a2RGqOS14rcibj5DEPnOXZU1bbF1EwevO2do4MtO7FGmOpM+H27t2tqCyxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556787; c=relaxed/simple;
	bh=hNAUqoB3Z6T9xcVaTisYvLXhaz4p7JHu9B8bQwwVxFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLFz/l5R7GMc2IcSfcyiIr8G1Vg9SNgvy6sv8/E5ZWMiH0N/yhVsBS9yRL2Ax1lEGlesJ9CkEtO+2IIAeZEDCyn0DSMy7XJKul3v+yQXylYelfIcBkvqV6uLH9y68VXet/v+3JKXQ5y8vvYqM3LlApUzFOa54B5UrYLS4nmg02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a8rE68eX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8rE68eX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gWhmwhXHiiEP6GTAYLPlvkBu8e2aLuQ2dYa1FSut00E=; b=a8rE68eXsjEwUbNFBOFarc/8FN
	nwljakc2/vlFYDAz3d272jKnocOcttDlJJUUG0ZB5NU1pRV0IFU3mMlOnGOFe/xOyaWZzQ1iojc+k
	U72yxY8v7rvgbJm/fPBbcbi2EKqsZTgxkFXmSWGkSx56M+51ZkO3xKXe+sfe7DMP9WD3Eu8+ByhZ9
	uA8isYO5brYcE4OQYQHHGPQeHTAS8HFG8dl6Gmg8tfVuc4Etzzf+P8dLIBbNVVpvAxptBWtId1UuD
	zhq6mbYqPCN3UdC4oGj5JmYQUV9+kLkBavdqOzreKWJLVzoA+gg+Jb0Z/zQKRRcqQjL4rJgElUa6+
	Z0GHq6BA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bK3-00000003JLm-3Q0u;
	Fri, 04 Sep 2026 21:19:43 +0000
Message-ID: <3c93e656-2c1a-452e-94d1-e4628624f5e3@infradead.org>
Date: Fri, 4 Sep 2026 14:19:38 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] asm-generic: fix repeated word 'the' in comment
To: Hemanth Selam <hemanth.selam@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260904105221.31836-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260904105221.31836-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 3:52 AM, Hemanth Selam wrote:
> Drop the second 'the', reported by checkpatch.pl as a possible repeated
> word.  Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5

Eh? What did claude-opus do here?

> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  include/uapi/asm-generic/fcntl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 883cfd7de2ef..f901ad3e6a7e 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -153,7 +153,7 @@
>   * record  locks, but are "owned" by the open file description, not the
>   * process. This means that they are inherited across fork() like BSD (flock)
>   * locks, and they are only released automatically when the last reference to
> - * the the open file against which they were acquired is put.
> + * the open file against which they were acquired is put.
>   */
>  #define F_OFD_GETLK	36
>  #define F_OFD_SETLK	37

-- 
~Randy

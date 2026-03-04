Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20819CC14;
	Wed,  4 Mar 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629548; cv=none; b=IYvrNPmMR9y3xVbgwpzcSCwALOc7l17SHwvlnHkjQBFiIgEHBu2MTNP9W/PRtZRAy9QFjENELGCI4vckl1fuRwTQqLCDTmKqkKHxNf17GblNJt6qNj1v28Rv9B8P4LBtp8hy7PXXQvS4GH5EnHUpJ4iH1vHR29lfO5BBLj4QDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629548; c=relaxed/simple;
	bh=ZBmofzGwhzP79Rc5S75dq/gVfqdpPnUKMrUu1TMPzu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrdQPM1xOhnEAtIHOMFzZUo6gLBRDjIJmXqZ6P/9TiVoOeL/Nf8kiSnEId3M8ev4MoaMsAr+03t45hMjMrkXfUVGfs8IjOtdAU5GwYtJwgK5RNgsyviHO+41N/lNBVYiyxsq4BdHRGHFJjiLeEClzBS1vzGMnPZ7K7ePBJ/mS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H2q9yuhI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H2q9yuhI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K39uJl3JutSidfsnOYKzt3yNIHwe2bQ/hH6CwSVtgkM=; b=H2q9yuhIhv5qf2rBzEo2YL6yNc
	S+wtLsHuM/40M7wq6L361SuTSc3vvEW/FTMqBfSTOC2mPKS2aFOEWb2A4MKjrMps9MwsRMDGWJZOx
	Ks3nQ+FZaqwvShVID38JiPjZmg4FLmzAm0wX4TLRgbHr7ZJwhVirIueaRjdLcTqBXmfo+BB1ut0Js
	gClIUc/ogPWhq0QKmF9YHfqQwyZ2+TMLtv2ILks/k8dMmZrkjUnATlekdF/5s9plS/xAoxn7Kefu9
	qNaPcYoZKd7qvOtn+o4VKQ/R6hXOzwocZRlkRGf+gZ2QmnTqGV7EwnS1DwBYRMNdSlG16FWNVN9z8
	wz4xoWHA==;
Received: from [177.172.125.177] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vxluv-008vXe-Kv; Wed, 04 Mar 2026 14:05:33 +0100
Message-ID: <654a6cdb-06e6-4178-84f1-8f88298f0552@igalia.com>
Date: Wed, 4 Mar 2026 10:05:28 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2] futex: add missing function parameter comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20260304005008.409858-1-rdunlap@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260304005008.409858-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 03/03/2026 21:50, Randy Dunlap escreveu:
> Correct or add the missing function parameter kernel-doc comments
> to avoid warnings:
> 
> Warning: include/asm-generic/futex.h:38 function parameter 'op' not
>   described in 'futex_atomic_op_inuser_local'
> Warning: include/asm-generic/futex.h:38 function parameter 'oparg' not
>   described in 'futex_atomic_op_inuser_local'
> Warning: include/asm-generic/futex.h:38 function parameter 'oval' not
>   described in 'futex_atomic_op_inuser_local'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D5347BC9;
	Fri,  6 Mar 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834180; cv=none; b=ia0K/v6zcH4JSE0IrwleDjQeojZO0AzymxSHn+f7f8o3VPrVSbFaEbQXZT8Dhrgp+s2kZVFnGTSVZ+h0syf3XaXeSCVdS1SeGSYnKLfirKMput55oIgDNvpOKQIWeQd/kODisgUOZxgdyOvUKwx6TvyLXeAFZlOcWj02HMCCMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834180; c=relaxed/simple;
	bh=4OFkYRr9cZ4fRUKLBvmBLoyL19F3VxIh4q3SpNnhvn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHVQhUTYZ1j51LzKzRmRmDElniEKxQg3EyHeBxVrFR0nA+eQrUJk4pane/g9doCoSDimQNAKqHvbk6z9qu/1m0RSWKEW5b/XBvgJPMwrw2rv7wi9xUogw8CatuSH/8ET1jHcf3Vbe4AcUp09YVoyLrmEDd9QoRNTiAkCpED5zpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P8ogek5J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P8ogek5J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6/AAr9LnkD2dAxPbfRzJYJELWMjL77lxMyMvwwvh9G4=; b=P8ogek5JpSIMF5NqbFXunPx+Bf
	rDrqRvz/SzPxyRSBYSFY3SPzICrEvpVH95ZIg3GalILVNilbJW0kPFd9+DwQ3hB5WHenVAQRHT6kc
	o9TJ++ZaBSfrws2xxy/AqZEtpMr1wj8bDUMgiMY20WHGRWwtG9GsIer+6JVRzxRwAlqV4fJYTVRBD
	odekNdOCGvSEaHYDbcx4jn3EVC8jNhwkKf3OZdQjOacrAtxMZS3GhIrRrRIxbJUq+PwhpqIfeMxtb
	Wu7ywM/pkU6jZFTyaW8F4OJ8E6gNU7kVxDi/0zkxzZhTvP9QtXdiR0zFkvnM1Ei5VmCDcsAeFExAY
	r9jjZCAg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyd9d-00000004YbE-0PqG;
	Fri, 06 Mar 2026 21:56:17 +0000
Message-ID: <dd235698-4430-43bb-8a71-6c2283247fd0@infradead.org>
Date: Fri, 6 Mar 2026 13:56:16 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
 mq_peek syscall] for non-destructive receive and inspection,fix minor
 issue,prepared doc.
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <20260306075009.83723-1-academic1mathura@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260306075009.83723-1-academic1mathura@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Warning: trailing whitespace in line 1763 of ipc/mqueue.c


On 3/5/26 11:50 PM, Mathura_Kumar wrote:
> +2) Motivation
> +-------------
> +
> +The original mq_timedreceive() interface exhausts all usable syscall
> +argument slots with mqdes, msg_ptr, msg_len, msg_prio, and abs_timeout.
> +Adding new behavior such as peek-without-consume or indexed message
> +access would require either a new syscall with a completely different
> +signature, or overloading existing arguments in ways that harm clarity
> +and correctness.
> +
> +By consolidating the message buffer parameters into a struct, this
> +syscall recovers argument slots for:

End the line above with "for::" so that the following lines don't run
together.

> +
> +  flags   - controls peek vs consume and other future behavior
> +  index   - selects a specific message position in the priority queue
> +
> +This design follows the precedent of other Linux syscalls that use
> +struct arguments to allow forward-compatible extensibility, such as
> +clone3() and openat2().

How much AI use is present in this patch?

thanks.
-- 
~Randy


Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B6366553
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527223; cv=none; b=W9E0yykIj04fB6x/nglEsofDZkvon3F5vqjT5R5e+OS18gRXru1kkTCSDDQaeXXNtGcFdeQScnptlpMvTszUff/43oIzdcWCzNTtKiwwoyR18Qtwrp1DNIF9bG+ORxkYB58CBS9fEt7uCPd3NRIYbHbNSlwv6K2buFsBxUwdnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527223; c=relaxed/simple;
	bh=ablOwMKQd22Q+KZBq9y4BMZVnNaLiD0FFqi08v9XFCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJELlHwPi29plor0963F4bNm9q8cFu6hmBm8i5ZgldRsHhUgPSM1jXkArkrSziRvu75G5UtGsgJwQapuNzUUsr0NtBve5EwqBCclivWSP/apF0pRjf9ZJuN3azrahwgu27UOTg1pCW1f7o1MITrxgj6TPjBigVxgFfWn5Ydrp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PS49/Xt+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PS49/Xt+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so44214505e9.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 07:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769527219; x=1770132019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpVju2z52ieKZ9g+UW8bQZ3qR3Ja1fAXqmPTBm/6Msg=;
        b=PS49/Xt+XBkvPmyiu7HuoN/+FQbWne3GuGTRt8FAgjemU+g0VSDoY5YDNkCt6aPhh8
         +YUL+8WHWYyYN+Bfzf6Pb0YJ/eJTEXSMMLpfDcGqiMJjA5X18sig1ycBF1++bPuhOW0j
         +06gCjnCrxJDM2e5OOUp/H47tgjuQ4ybDtjc7grIkF0qtmGWnhXBmUc88b/8E4BowpFq
         sDFKtZ0UGspdRgOnkYrDNKpiBX6UZA9bVhZgKyXsU9wLNmWgEr7+FzeQJYFFU4gqwTr5
         QbDKPSeDpC4WeQHTkReLy7m2xU4YFUCmweL0PWjLUqMn3CMaftJBwZwhsAGRenzh51WC
         biVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527219; x=1770132019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpVju2z52ieKZ9g+UW8bQZ3qR3Ja1fAXqmPTBm/6Msg=;
        b=QHDOETRu6mJUCKUccAxCZVN0KrolTeOlTDMds8KRw4i78+GczdAliyPesFH/Rwb3x/
         geZswwMBq2YwOPZ9E7Wc04GUQ/zJLCKx8BXjIzgJTSxvoaIFsBc5ZncSTNEd3612M7OF
         zAsNsEeKUYISuVCygLvVkAANcFnNmaCLLUO2blaItcYd7lA38cZPOxrAw/bKCPXmAO8h
         OOhiXGkXPNhO6kAzPPYu1Gt0Cxtq10GUcLXEwlcBcJyJOGErwhYIuss23du2UxnmcBuC
         LH2vRMEEKTcP8ZpMvR8azLlYYgU00KOwzp4qPW1XXhp9GoRVy/6PNSBunW4HFcZk1WU1
         y+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWtWq7MUt+oiUuRJX/KA7fPIcRAFq54kPun7uHUo2UCbrLqqn52HGwkCGuaXSkae3Rn23+2rEHxpXzj@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQllmAQiVdkQ/R+qeSD5ZLQ0OjjUo+UVxao5hzI5fWqi0jdlk
	rm8q39x0PGO5c/edDU1LxYmk14B1+oZMKlH0zm7e5OXe8OPoYQjCPRzhk/sXJ77Gquo=
X-Gm-Gg: AZuq6aLew7L2vz/Fni0WpLuVZRU4vAdbkp80wRihbuwXsrVGEHD7yS2Hx2jFWcYHngg
	/QE3NV+3Nywp8ZzOAHgqzU1Mjrhck1pNX9BqG5jy03EZ0f7Y4tkEVQ76XBGxFHjWizaOPvOQHe4
	N9FE89YjzuhvHP54uAmdaSWdDvQliZi28IqXoT+nor64mwRG3lI812jZj3cFUXhir076YAZQ77Q
	EZJXDbaG38to6krb1MvtR8jc+2H2//vvY2Al9IZ32ETj3pfVscSeT9P/KLGg93i2arhZ1ErDKMp
	7qCeoOPGa6LW01TKP+Ugcsvd7AjXp0c5horEs070OMV36Bzuy+yfTd3khNPQQ5J5SNA/08d4um5
	maFkZ+3++fvbaGS0pR5NSTb+GtTDZchKfAlYHSwV9SVLpohkn7LD6SG5ZKu88QJ0is9GHT1LqMH
	ci2WJSAw3hIkjNVPA6/qHPFhLoLSLQm0cDAc+FBsb9
X-Received: by 2002:a05:600c:5553:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-4806a313f35mr20307595e9.19.1769527219144;
        Tue, 27 Jan 2026 07:20:19 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c034dfsm67200105e9.10.2026.01.27.07.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 07:20:18 -0800 (PST)
Message-ID: <52cbbccf-d5b6-4a33-b16a-4a09fe5e64d3@suse.com>
Date: Tue, 27 Jan 2026 16:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] module: Deduplicate signature extraction
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-8-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-8-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The logic to extract the signature bits from a module file are
> duplicated between the module core and IMA modsig appraisal.
> 
> Unify the implementation.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  include/linux/module_signature.h    |  4 +--
>  kernel/module/signing.c             | 52 +++++++------------------------------
>  kernel/module_signature.c           | 41 +++++++++++++++++++++++++++--
>  security/integrity/ima/ima_modsig.c | 24 ++++-------------
>  4 files changed, 56 insertions(+), 65 deletions(-)
> 
> diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> index 7eb4b00381ac..186a55effa30 100644
> --- a/include/linux/module_signature.h
> +++ b/include/linux/module_signature.h
> @@ -40,7 +40,7 @@ struct module_signature {
>  	__be32	sig_len;	/* Length of signature data */
>  };
>  
> -int mod_check_sig(const struct module_signature *ms, size_t file_len,
> -		  const char *name);
> +int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
> +		  size_t *sig_len, const u8 **sig, const char *name);
>  
>  #endif /* _LINUX_MODULE_SIGNATURE_H */
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index fe3f51ac6199..6d64c0d18d0a 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -37,54 +37,22 @@ void set_module_sig_enforced(void)
>  	sig_enforce = true;
>  }
>  
> -/*
> - * Verify the signature on a module.
> - */
> -static int mod_verify_sig(const void *mod, struct load_info *info)
> -{
> -	struct module_signature ms;
> -	size_t sig_len, modlen = info->len;
> -	int ret;
> -
> -	pr_devel("==>%s(,%zu)\n", __func__, modlen);
> -
> -	if (modlen <= sizeof(ms))
> -		return -EBADMSG;
> -
> -	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> -
> -	ret = mod_check_sig(&ms, modlen, "module");
> -	if (ret)
> -		return ret;
> -
> -	sig_len = be32_to_cpu(ms.sig_len);
> -	modlen -= sig_len + sizeof(ms);
> -	info->len = modlen;
> -
> -	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> -}
> -
>  int module_sig_check(struct load_info *info, int flags)
>  {
> -	int err = -ENODATA;
> -	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +	int err;
>  	const char *reason;
>  	const void *mod = info->hdr;
> +	size_t sig_len;
> +	const u8 *sig;
>  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>  				       MODULE_INIT_IGNORE_VERMAGIC);
> -	/*
> -	 * Do not allow mangled modules as a module with version information
> -	 * removed is no longer the module that was signed.
> -	 */
> -	if (!mangled_module &&
> -	    info->len > markerlen &&
> -	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
> -		/* We truncate the module to discard the signature */
> -		info->len -= markerlen;
> -		err = mod_verify_sig(mod, info);
> +
> +	err = mod_split_sig(info->hdr, &info->len, mangled_module, &sig_len, &sig, "module");
> +	if (!err) {
> +		err = verify_pkcs7_signature(mod, info->len, sig, sig_len,
> +					     VERIFY_USE_SECONDARY_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
>  		if (!err) {
>  			info->sig_ok = true;
>  			return 0;

The patch looks to modify the behavior when mangled_module is true.

Previously, module_sig_check() didn't attempt to extract the signature
in such a case and treated the module as unsigned. The err remained set
to -ENODATA and the function subsequently consulted module_sig_check()
and security_locked_down() to determine an appropriate result.

Newly, module_sig_check() calls mod_split_sig(), which skips the
extraction of the marker ("~Module signature appended~\n") from the end
of the module and instead attempts to read it as an actual
module_signature. The value is then passed to mod_check_sig() which
should return -EBADMSG. The error is propagated to module_sig_check()
and treated as fatal, without consulting module_sig_check() and
security_locked_down().

I think the mangled_module flag should not be passed to mod_split_sig()
and it should be handled solely by module_sig_check().

> diff --git a/kernel/module_signature.c b/kernel/module_signature.c
> index 00132d12487c..b2384a73524c 100644
> --- a/kernel/module_signature.c
> +++ b/kernel/module_signature.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> +#include <linux/string.h>
>  #include <linux/module_signature.h>
>  #include <asm/byteorder.h>
>  
> @@ -18,8 +19,8 @@
>   * @file_len:	Size of the file to which @ms is appended.
>   * @name:	What is being checked. Used for error messages.
>   */
> -int mod_check_sig(const struct module_signature *ms, size_t file_len,
> -		  const char *name)
> +static int mod_check_sig(const struct module_signature *ms, size_t file_len,
> +			 const char *name)
>  {
>  	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
>  		return -EBADMSG;
> @@ -44,3 +45,39 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
>  
>  	return 0;
>  }
> +
> +int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
> +		  size_t *sig_len, const u8 **sig, const char *name)
> +{
> +	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +	struct module_signature ms;
> +	size_t modlen = *buf_len;
> +	int ret;
> +
> +	/*
> +	 * Do not allow mangled modules as a module with version information
> +	 * removed is no longer the module that was signed.
> +	 */
> +	if (!mangled &&
> +	    *buf_len > markerlen &&
> +	    memcmp(buf + modlen - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
> +		/* We truncate the module to discard the signature */
> +		modlen -= markerlen;
> +	}
> +
> +	if (modlen <= sizeof(ms))
> +		return -EBADMSG;
> +
> +	memcpy(&ms, buf + (modlen - sizeof(ms)), sizeof(ms));
> +
> +	ret = mod_check_sig(&ms, modlen, name);
> +	if (ret)
> +		return ret;
> +
> +	*sig_len = be32_to_cpu(ms.sig_len);
> +	modlen -= *sig_len + sizeof(ms);
> +	*buf_len = modlen;
> +	*sig = buf + modlen;
> +
> +	return 0;
> +}
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
> index 3265d744d5ce..a57342d39b07 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -40,44 +40,30 @@ struct modsig {
>  int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
>  		    struct modsig **modsig)
>  {
> -	const size_t marker_len = strlen(MODULE_SIG_STRING);
> -	const struct module_signature *sig;
> +	size_t buf_len_sz = buf_len;
>  	struct modsig *hdr;
>  	size_t sig_len;
> -	const void *p;
> +	const u8 *sig;
>  	int rc;
>  
> -	if (buf_len <= marker_len + sizeof(*sig))
> -		return -ENOENT;
> -
> -	p = buf + buf_len - marker_len;
> -	if (memcmp(p, MODULE_SIG_STRING, marker_len))
> -		return -ENOENT;
> -
> -	buf_len -= marker_len;
> -	sig = (const struct module_signature *)(p - sizeof(*sig));
> -
> -	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
> +	rc = mod_split_sig(buf, &buf_len_sz, true, &sig_len, &sig, func_tokens[func]);

Passing mangled=true to mod_split_sig() seems incorrect here. It causes
that the function doesn't properly extract the signature marker at the
end of the module, no?

>  	if (rc)
>  		return rc;
>  
> -	sig_len = be32_to_cpu(sig->sig_len);
> -	buf_len -= sig_len + sizeof(*sig);
> -
>  	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
>  	hdr = kzalloc(struct_size(hdr, raw_pkcs7, sig_len), GFP_KERNEL);
>  	if (!hdr)
>  		return -ENOMEM;
>  
>  	hdr->raw_pkcs7_len = sig_len;
> -	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
> +	hdr->pkcs7_msg = pkcs7_parse_message(sig, sig_len);
>  	if (IS_ERR(hdr->pkcs7_msg)) {
>  		rc = PTR_ERR(hdr->pkcs7_msg);
>  		kfree(hdr);
>  		return rc;
>  	}
>  
> -	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
> +	memcpy(hdr->raw_pkcs7, sig, sig_len);
>  
>  	/* We don't know the hash algorithm yet. */
>  	hdr->hash_algo = HASH_ALGO__LAST;
> 

-- 
Thanks,
Petr

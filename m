Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AE3469F8
	for <linux-arch@vger.kernel.org>; Fri, 30 Jan 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771629; cv=none; b=B1Vz1DkNVNQAYzBP48LgrYbrCI4NdiM+dCPp96dZMNJ+250XaMmaRg3e8ASFO+sSE+r5KDL+oB+0KIz3Qh0GGVU+WhqqDBapp5W4V26qvp22gtbV7zIELFGyZLEj0Ab/XuVk57iBCVDlHwXuDBJQ4xWVIGJM9U/eltT+0YKxcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771629; c=relaxed/simple;
	bh=TCis+rQCC6z7XYAkYemlUIoHru5jgaTIrUqt6t+FWY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwiimgnbhE9zvgSNO2MLkJ0qwNMmTva03Hv2d45AkRCuRZmCV2EH6KSR0t8l5SJj8kOqY3/qhOOo9S4bsOklDuF19E1NeoIET8hqUnIeFHuqmBK/eL4CFfEm5nn+vio6e7/+Cyv/dwJp9L/xFb+m2zgTgN5PhEBWdmrFUIWzADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bijCiHCD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bijCiHCD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb2314f52so1225765f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Jan 2026 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771627; x=1770376427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+yjYwZ7RDCJlqlGtt5ChUntZSWDd8aPFqDlY3AniEk=;
        b=bijCiHCDiDsrfYSkVIjAqtFdXK0pP3y5v8itW4VnLqZB29KGa2STuu35LNttVG3FeD
         3c42LD0VN3OVZl0OwXHeg2zrB8V3YNvwyL0HXxsDzB1qcEZ+YwhJ7CMckfyeQ+x5xU72
         s2CrtAtfxPINwcj5teHNx/VBE9F7lnSx4sGwHfirvj88paMTt7kmu14fQ0auD7MuVxvX
         8DnEgXkyvEy22rxA+B3tXASXH4HcS+Nki6mWmlmUFHjtWbY57ac9OYUKL90KW9PJMiLN
         AunrO3J9F9L/zmEkvl+41y/JuzskrpStPTww79WkogBJh0QU+QarB0Sj1xg+1k9NaeNx
         ZBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771627; x=1770376427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+yjYwZ7RDCJlqlGtt5ChUntZSWDd8aPFqDlY3AniEk=;
        b=KPZD1arFbXNALZfs3vu119NjekjVoRNqKGyamsf7Mwwjmbz/vTmMDxSWNqNDuM+meW
         9GWAXSlEgJuWSdyy8aam6TEHtCei21uBZi+268ePfWQtaZgi2+RO2eTKFbOm5XQ2amRx
         j94Cw47LWdtBNOke+NKmuirS/sbIR5QIPi2h1yOULvtTkG3KVqzGY8hRHA/1lN0A7Prh
         zWgAD/jIzZQnKiPgtRpic/ooRpsurgabyXBWmk9X8Vsq+O6ZCgt02NyNcZn+bJVJ6yKL
         tOw/luV+J5FZvwmSVp503bDg0XIoSQdZ8rMUpJWDDkKMcaRnK383Y8wlya4pA99wjwDP
         JcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7I7nfZvkOBdhWSWA8olHUixevg6WIwTehZ8dd5oWDaKNdANeEvYKsUQVK2/rqTIyDQ7wFVhHLEAX@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlBgr9TxD4QSi6TO2oe7uNGkm/iXr4J6dQyC1OQdhBx+XBUhV
	GAMpVvA2iueQPcMs0PzQD5gOt01RR4grDtDp8Rw9BVDVaLn+WE9/5+DR
X-Gm-Gg: AZuq6aJzXa6jMwlVCsToBvwObTSFqctr/oprDQi/XA28NfwUr6B7nU/CmVNhCAL1yC/
	TrVJ/6dbxonyQBVj80hVBLTocNhomTAJIjaVr/TOF/3DIIlJOGdN/ApJNFyCw1BwAXLbpGS2JzO
	0M256sQhfkUzlSn3Hbfp9tCjTpNplLlYogh4UVs/B1ISZLKcm4H31CPYSZg55hp7m1cF7Bl1a5n
	3NlNEq4ABgmGd/ml7+Z9Kx1j/s3lM+FhrLYznu2R9Qz8WcHKm37doyzFjesmGBeeSVwvtfPowkv
	EQ5MOwwUec5gf97o7LHrcDkHi4kCTTky3uKiulb1rk2oCXwFgXhHoYNhyD7MKkDlPl45mbgSis9
	sUWBk7Gc9mkZmEGk99QwJVAwe9LOa2ZC3ZFWekuxEoGXYXqATZWDmnhFTlHK/bFzoXjpZoAOvFY
	Qn5MR6/BjqaLZfo5RZVl+GmzWZTks9ytlRB+2O2z4gcTVV7IqwapUKeb+HtSu+3FPLnf+wf0w0H
	QfS/AnEsS8yPckbf5HG5mFhBo6sF1S5GciKYNWd3qc7/vE=
X-Received: by 2002:a05:6000:2905:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-435f3aaf59dmr4092783f8f.44.1769771626677;
        Fri, 30 Jan 2026 03:13:46 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:99eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfc9sm21437487f8f.21.2026.01.30.03.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 03:13:46 -0800 (PST)
Message-ID: <c37ae03d-2b0e-4179-ac22-7d0c01ff601d@gmail.com>
Date: Fri, 30 Jan 2026 11:13:35 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 matttbe@kernel.org, skhawaja@google.com,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
 <20260126173124.1f0bb98e@kernel.org> <aXhUfC7ZyYge1jti@mini-arch>
 <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/26 06:48, Bobby Eshleman wrote:
> On Mon, Jan 26, 2026 at 10:00 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
>>
>> On 01/26, Jakub Kicinski wrote:
>>> On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
>>>> I'm onboard with improving what we have since it helps all of us
>>>> currently using this API, though I'm not opposed to discussing a
>>>> redesign in another thread/RFC. I do see the attraction to locating the
>>>> core logic in one place and possibly reducing some complexity around
>>>> socket/binding relationships.
>>>>
>>>> FWIW regarding nl, I do see it supports rtnl lock-free operations via
>>>> '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
>>>> recently made lockless with that. I don't see / know of any fast path
>>>> precedent. I'm aware there are some things I'm not sure about being
>>>> relevant performance-wise, like hitting skb alloc an additional time
>>>> every release batch. I'd want to do some minimal latency comparisons
>>>> between that path and sockopt before diving head-first.
>>>
>>> FTR I'm not really pushing Netlink specifically, it may work it
>>> may not. Perhaps some other ioctl-y thing exists. Just in general
>>> setsockopt() on a specific socket feels increasingly awkward for
>>> buffer flow. Maybe y'all disagree.
>>>
>>> I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
>>
>>  From my side, if we do a completely new uapi, my preference would be on
>> an af_xdp like mapped rings (presumably on a netlink socket?) to completely
>> avoid the user-kernel copies.
> 
> I second liking that approach. No put_cmsg() and or token alloc overhead (both
> jump up in my profiling).

Hmm, makes me wonder why not use zcrx instead of reinventing it? It
doesn't bind net_iov to sockets just as you do in this series. And it
also returns buffers back via a shared ring. Otherwise you'll be facing
same issues, like rings running out of space, and so you will need to
have a fallback path. And user space will need to synchronise the ring
if it's shared with other threads, and there will be a question of how
to scale it next, possibly by creating multiple rings as I'll likely to
do soon for zcrx.

-- 
Pavel Begunkov


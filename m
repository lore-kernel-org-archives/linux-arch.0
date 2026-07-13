Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733A353A74;
	Mon, 13 Jul 2026 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931587; cv=none; b=q9jyqXDoEewuy5ptJXHqwEEiUZyjhXy54p9WPlns0cgLQh7/64ChdMYBZYlFoKF1lRz/QBcS+4kdMqOWflmIMFNts/3XEgcurgHj0UVbsjP2QIkZGXuGia3b8C7mAb1LR5J0T1yBmwxpnjk0zpvm05vjXBuiCGTm8DTy801RhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931587; c=relaxed/simple;
	bh=lfqPPDURDF126f8/FTiKcHMEjNjNldLcChOm9gZ7mjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ykjo6mHkskd72NJlO3Z/mkKbgZ3FCah9sVSm4ffn/MSRp8wBnozShfY4gBThHK491Bx70S+qAmcRK7rcI/F3EXHaRVeW3bcca+AO/1q5ldSooGOKQ8t8FYde/nBA9OYr9dal18fgyON5adGgeyDg38dXlpLDO5bqqAuZ2cdPbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RKqDyqg3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRHVZPmz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RKqDyqg3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRHVZPmz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5267A14000A4;
	Mon, 13 Jul 2026 04:33:04 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 04:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783931584;
	 x=1784017984; bh=Eyw96bBvAll1OrR4lFkKq1W8auSNYYeqQdv4lXCe6PE=; b=
	RKqDyqg39PPOSN6iwUD0DkOUcF3taspjIWcYrevXatw4wOgMiscECjjEJDp3Njlg
	VVvcuJ6bFdsyRQf5SvVVYgXYXz8m157Ri+/Ry9PBxttZdHh3txL6IrFWEDu3h9r7
	sHKvotRUVk4jDxQQco5SeBQO6qZtjkEuz+PxX+gkvkztbZ5XvhzCZqm48D3UOE0w
	KevsyqyrG5EIvFKrjOKmBEHoJu/erbkZot8eVEAWnSoEX90FIieiR5npfx8Gkbi6
	gVtDclTUKVcJSgLDhyricDgrXQZESOyulmJBDiTZenjxL1TsRXGhvLFLECgNwvNg
	wuSyMlCEioTQVWrKo1Zgkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783931584; x=
	1784017984; bh=Eyw96bBvAll1OrR4lFkKq1W8auSNYYeqQdv4lXCe6PE=; b=o
	RHVZPmzPJZj+Z6vnNP77h+KvRIBNgChRl/jPMsxuRpzeBTrsVeew2O7QgbQE//G0
	YHkD62QrelhSbu1Ii7Y893pvKLLSzpaKkoRI52JwdYQzkYZ90xKe2HJg3jR7ULzL
	3Kp8SilpSW1dY+8i8R+4wkOir+Bi+Igu/IlU3oCPqlLwM5pbWJjSvW3qqK+miXri
	l3YhSWYOTFZ3pwPJcB5mNuP3sId544LJI05qMCO1CA9UrcJwtLXYqx+o/jJoFZA6
	4f5zi2CvHTzLAGrEcwPlBST9dAXFz73W1Zx2vWs046wgB1X1A6p59v12t/S5vLyE
	jqRYHP3XSYr45FxXh3W7A==
X-ME-Sender: <xms:v6JUapp5NrUvV2iO8nb_vhJ_dI8gqxhDm54W5_hs3dYJv9Mz-sUQUQ>
    <xme:v6JUamf2-JqxEZ7paIT0pIRB1aKpvJ3Aa_dtt5ZRAaupZUYyVWShIoOe9-wl0P22r
    YRQm-Ofu_0zoIcfWo5DvjS0TFpIb_G3IZSxYsAJiJrURNhX--_dHeM>
X-ME-Proxy-Cause: dmFkZTGzWkrVyV3cq0E8zUgoW4RAK29kNHKzD4mbE/FJ8aG4sHvSk5s/h0lhj1IQga9iZ6
    NnPEf8dzWPgg+MpDZW4GHUqEEB9YoEQvXiiw4XT9bFADsbSp/MRhAzQsdDfRr+Ocx1Pptd
    VWEawzGPbFlj3G+s16fNlsTLMpQPsZK2DZo+U1X93kD0DFX6xHKQc/X9G4mdENgJYUco6A
    UH/gLd4yoImZ5mpCtKYTQNWmPHZvC3S0Lhk7jPm764h8VFnoPYSgrBAcVtzscz1RnMkkX7
    0e8w9WMXalLVruPkKZoWRsn+ZckrQ7n6I3ucN35Nuu8tgIm16mZxJM5kVDtQE66Fx/Q4kK
    rfmHbWR17QXPGhfeo5wDQLULxbIGfq0L96H2VH5xBlfETpUvCoZiLeOHJu6YFP4aU8fRv5
    EoTccWbhrPJsfgt7PDBQeBnbn0WGvQFQcWTEXyEK8TXYA3758o8wVY9xL9h40cwjFq8iqZ
    3PQwlTvI4qZu2caUoI9AgBcjRvXzszPNC6VyyjFMAQNzdzGAS5bKt+Z0jj+jJXAfB2Y+fS
    J5V7tEFYIYMHdzxPIZpHWVvMLNafsoIs9dSIB9GDoqHHtmPnnQ8wScd2L/C7CCW+ORlGAJ
    n3CQCwYLCgt3GzjAa/sF5SWDI5nJgQL7F2Hnqsj1x13ldXQrjBqGxxA/oqbQ
X-ME-Proxy: <xmx:v6JUamN7QtdIhtiR0Pw3oudOd3qcQYo9-PXLlBE2Jsck9sUo0nvPzw>
    <xmx:v6JUatsWlphcLijL2UWLyaCKcqX8vYzjpf_FKn7QfrBhSdHAQ4uarQ>
    <xmx:v6JUar-c8xYqvLzBxSbF8z2AQQACKkj0XAPNMQ2r1lnMVAINoDWVEQ>
    <xmx:v6JUapHuuyga36TA5xdn_5CtoSayYxDRotzCAxeo69C_WWMa86qiNw>
    <xmx:wKJUar0l4RHtKVk_AtUuXMDxolNvnRwT3E4lV1Cx1omoIgm4AqTYrtcg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7ECC5182007E; Mon, 13 Jul 2026 04:33:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2UGMrT-rt8g
Date: Mon, 13 Jul 2026 10:32:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, da.gomez@kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, neelx@suse.com,
 da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co,
 mproche@mail.com, nick.lane@mail.com,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com>
In-Reply-To: 
 <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
 <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in modules
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Jul 11, 2026, at 01:13, Aaron Tomlin wrote:
> On Fri, Jul 10, 2026 at 05:59:59PM +0200, Arnd Bergmann wrote:
>> On Wed, Jul 8, 2026, at 04:00, Aaron Tomlin wrote:
>> > Currently, the "module_blacklist=" command-line parameter only applies
>> > to loadable modules. If a module is built-in, the parameter is silently
>> > ignored. This patch extends the blacklisting functionality to built-in
>> > modules by intercepting their initialisation routines during early boot.
>> 
>> Andrew already asked you to provide more background on what you need
>> this part for. Do you have a specific driver you need to disable?
>> 
>> Can't you do the same thing using initcall_blacklist?
>
> The primary motivation for this patch is to provide consistent
> administrative control.

Ok, it sounds like you don't actually need it then.

> Regarding your suggestion to use initcall_blacklist=, while it is certainly
> a capable mechanism, it is fundamentally considered a debugging facility
> intended for developers.

I don't see much of a difference here, it's clearly still only a
debugging tool to me, not a general administrative interface: turning
off a random built-in driver likely causes undefined behavior later
if there are any other drivers (built-in or loaded) that depend on it.

Overall I don't think it's worth the added complexity.

     Arnd

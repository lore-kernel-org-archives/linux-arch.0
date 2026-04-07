Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E12F60CC;
	Tue,  7 Apr 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567459; cv=none; b=ecloiY19sPG9u+fnovrGg+Sx53X3ZLQZhCgHIZFTDCsImFOlbuqrKQhjYIih0zBuHoa1mzu4M7HnzD2NEDzOvT+Xbfj0AlKSg+x/oPIr7AN7fKE3/L/XBj8iIamE0SPJ/5k9sCJ4RNTXxTcj09yUunZzqSCytYYghcMp5yAC05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567459; c=relaxed/simple;
	bh=KpD+Khx1oqJyZimWBbKtEZ26IJw/Q2XHeaRqUitzsBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdDUhkxhJrpQ+t9BbCjxvdWkSbO/s/i3hl7KgQxPUm9l1ooFLaLXo/lE3bWElI8Osq+bVyb/xAHMN7jaCdGd1fuwu88gJm+taliMQMjZDXGaIDirCg/dCyHkdAEs2YzUgN09uEpSUWAup1OtGBB0Y116pPEnatpSznrywnjKd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=AP9yz0zX; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="AP9yz0zX"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id D0E3CBE6B0;
	Tue, 07 Apr 2026 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1775567450;
	bh=KpD+Khx1oqJyZimWBbKtEZ26IJw/Q2XHeaRqUitzsBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AP9yz0zXGu2KK0QDufayJqpqDuM71EYdHKlEW6damrf5BwzmPBa97Kw46ITbFTgtN
	 F45IKIgGzyLvE77qoWJiIxTll3ffbvynEFRFqNLTFK1t7mQld67YVNsSGjoOebJGBe
	 WEhDJEdzLuNr8ZAUMz/Z9poZCTDWNbyeGF95y78E=
Date: Tue, 7 Apr 2026 13:10:48 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/5] locking: contended_release tracepoint
 instrumentation
Message-ID: <adUCWOUR052gM5xd@shell.ilvokhin.com>
References: <cover.1774536681.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774536681.git.d@ilvokhin.com>

Hi,

Just a gentle ping on this series.

I'd appreciate any feedback. The spinning locks part (patch 5)
would particularly benefit from review.

Peter, Steven, any thoughts on that part would be greatly appreciated.

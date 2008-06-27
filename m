From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 02/20] mm: generic show_mem()
Date: Fri, 27 Jun 2008 16:43:30 +0200
Message-ID: <20080627144329.GA7634@osiris.ibm.com>
References: <20080627115349.743368154@saeurebad.de> <20080627120048.059732179@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:56118 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbYF0OoV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jun 2008 10:44:21 -0400
Content-Disposition: inline
In-Reply-To: <20080627120048.059732179@saeurebad.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> +#ifdef CONFIG_HAVE_GENERIC_SHOW_MEM
> +void show_mem(void)
> +{
> +	pg_data_t *pgdat;
> +	int total = 0, reserved = 0, shared = 0, nonshared = 0, highmem = 0;

All of these should be unsigned long. Might overflow on very large
configurations otherwise.

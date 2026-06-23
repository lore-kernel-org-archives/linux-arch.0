Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C274BE1;
	Tue, 23 Jun 2026 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233169; cv=fail; b=VLzn1B/pVkPGlztnwHEn6XdFNHQGJRBun7HJfgfY4RdbeZfLwKHVv7sOj3ER6rxq+mpIrGLD5ze6gYGF56YTXYcGUg3MJ0EwnhET2C5AtCHnks+1pmzJLSOiH6jStT6UNFZYCKgwNlW7aAwyAXy6JqccIvD6wcA2jGTLXhjjH3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233169; c=relaxed/simple;
	bh=8cAA/I1u8wlcfHHAF1bfww2WGtkcWNOY6zRHnKdfgVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JtRT4s5bkP+hunAm64era3ooI/AF43W/TqisSW0gqmru4Qgh6d5V1qqhT6YDRetbyxH2dOAI6IiPT9+YWEeC+EzS9E6GwidAXeMwuJ5Z7SHRjiMoyfNdC6txcX7x7tnP+oH48aYHCqs+yQA0+5fY382e6Om9XQhvu8t5fvcg7AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HzCwWVnW; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HzCwWVnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdxnihHN2My2FqVIjkRecQOoE0dSvT+z+RvjOS3yQsUQyAx5cBYRxaO0d7ZuQ0BKwtG9yOw5INgT3ozH8NbTOkKD8HSKtDsaWdm6bENPosjoxl9n2fUtO9D1HOWh5AVTw0jAFucbp1o1rGflwRj05dNhjBW3BMG+nBZ7dUlhq+m4nn01Wb/7TcgDszc9duk0v8fnC2O6fOoco8avc5LXHe6AOjO0IXNXPg1D2yOl0sqJcX3zCfINB38zKZ46LAAzpirNVK/6azTmUyevSGZTr7eP+Qctlxwjanf8bqNZkcVYjiGAShZy8TV163TdXe1U7uoyt4vsut8Mi24znbGH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s1YAXm29aeFrrVleGa8ZFBIByiPFazttMHQUreDam4=;
 b=yC00CGVNYK3vseeYaE/42b7nN5Z+nm8GrGFY+6uHbTK7cmy9hMYrqEWeVMHD09gxh1QbdZQtNGxsbddEdE7+/NJi9AqzmcttfLBClGCC/DQ0W1JldmQeRZmuGpF7cq+wHAR0/1AyCH+Des/GDO6lY7oNQmIDp3ryl7CX7hB8UwAVOxcBEO15n0tAo3SbMyKEcE3YYMJaj3NP7ywreXq21GCPuvsGqcWEGKE/9jWiFZypBSOJLQdwKroypcuHVbjO6+j6G06nAY7xc9PdKtfo7uGSoLFENPW+U+nDga1D5zgAbeFvQcdAKDZm8iVpwgJ/EXVr6trJYCTl6RyBkiJ1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s1YAXm29aeFrrVleGa8ZFBIByiPFazttMHQUreDam4=;
 b=HzCwWVnWuh/xW6rPHcMr2iNCdWH4ZrTHUvMK0rCsP9d3DOatTrjz1icsSetIut52qasqZerLUfsv2Vr6y4rCg0vNjN9X0poq2jmoNJhQeztiWhO5dWpfC+I1hyET+7SepRJLAzIMFH0BTCOmPEQaP8fAy7vCSiiILoidnwfI+CjhDaIjv0aT0nAuCBJ+/h1dqraJ3TK2UQ1r6PDIKGE4N0dTZCPZO1wNrVQVXQJJ3n3FzxnDycJlbiNLVgWfxqaKi+MlnJ6XzlPazzG7HjNU9Q/IN/z+iXLHqIebOYOwJKr3rmCsSr0gZVjUZxhYTSeqwa+I5uD5M9NhKnYCWhd9SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 16:46:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 16:46:03 +0000
Date: Tue, 23 Jun 2026 12:45:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Shubham Patil <shubhamsanjay.patil@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH v9 2/2] i3c: master: Add driver for AMD AXI I3C master
 controller
Message-ID: <ajq4P8G1BXaJ0jDu@lizhi-Precision-Tower-5810>
References: <20260623114417.2578189-1-shubhamsanjay.patil@amd.com>
 <20260623114417.2578189-3-shubhamsanjay.patil@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623114417.2578189-3-shubhamsanjay.patil@amd.com>
X-ClientProxiedBy: PH3PEPF000040A4.namprd05.prod.outlook.com
 (2603:10b6:518:1::53) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6ba191-ea73-47bb-c510-08ded146e988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|7416014|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	JLwO1O2/pLWvrlGHgMA7abU8mIsqECugVFJZXc4sCds+RyR6GkVVAVmyMYxYY2sbkhI3O40J7qLKahjcMwCJ35Ne4DGMucGMMIpjtKker8+nBQO2DmtG5x44cb7LzKXp48C6S5wlgxwSwozSCxez74VIpYSdRtsFOG9/zOCGfjB2Djvu7JISVmHCHMIgLJEHWck0z3LMZGhcTau9XkGkX6Hx1vX5Lyay6ZqOeI/9saCENE5XNz+ley+7Lfmo7nh3GJbu/h/YWRC7wdrKC+FtbhSoXURYZMSeT0X8hKST4Qy+yKLD+iD8gK/Q/3coBYV+JBT72zINhUwIjn1njt5+pqDyrCH03sSUlNX8KEjgye2Ri+LUjgbOiMflNnVbQEC00xcTUHfjyb5R146Ivofgi0Hx7a9l9xX5mphOowTyz3GRo/xT++HtRcrrImQu1bOkXgThYYkfl/y0mF5DNKqs2bMDCuic1zjVEsuD1c2BIRV/6kPs6xoqCC6dOFmR8XTh2h6lS5LysFSzF7TbLyy9uiEjxr+2p0/sMmYW6NhMqTMdrWgH/XH6gEz1+Z6jhl84ImlaePsUwNN2ND+yLuVCMEp5ojBFalrsCYB0d8fPoK3IkOfD+83ZH1KVkQJxrygAZawD5rw63LtFCahQnAKF5ptJvWYx5PXM9IPHf9INJhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RveKnDyCO6PzHOv6A4miIFuW2sRLlIHHb0+g3RvNExn1+gvlaTVup6TXO1Kv?=
 =?us-ascii?Q?wPwJhF5j0KbNUBsSS/thKDOMteUV4csvBmyiXPLn5CVIcHSPdXFPWuPEoaHq?=
 =?us-ascii?Q?cGbYXSqIj7jrceau7MduP2irV17ep6+h0/DEfSfsHfcA64HlRA/KC1FtxcIe?=
 =?us-ascii?Q?gME4Qx99M/iMs4H+Qoo/T+wemDMKJTcUEduuwo9UI3OlPKikyQORMT4UFFJq?=
 =?us-ascii?Q?nQ6dxZkQPOjsGLlZm6c0RdQxK0BCIkJB6cyqQRo4GuRW7ZZO+KoG1zveoVeM?=
 =?us-ascii?Q?Apu79aUndhY4Kmz6KsJwyJVqbkx/+G6z7BMqXlXNsjgl2XPxj/yC0+G5ke/P?=
 =?us-ascii?Q?srcxcp7dU4ivUrERI/vpgLstxjsLpwHeIUiVleFd99h9j9PjbnLRZFxgqGVB?=
 =?us-ascii?Q?o1AO9fVBw++xBPfVtwLGhroVbQP0G606Jh3hef5BgZ29tj0l2kJmL1Y0R987?=
 =?us-ascii?Q?N02OkTWWbgc8PF/ZZH8fM9aj9TtcoVwcp5BD70P4ckhv+nRHmprFeGXg5L/n?=
 =?us-ascii?Q?Sso1fCw0CCWN3VTIgBGVyd5i9pf9uzHak2tODxfyEvpyhxzxE4tqaSb++IRE?=
 =?us-ascii?Q?HJSSq++cWTiBwti5BbEiCIF5a32ef9KkGsp/szbT4CHxj2G8h2lV6PDc13dn?=
 =?us-ascii?Q?ozLEMkjj5a8SBpBAy7cYQG6+LRDvWw+VmAsRz98CvJ3+9PItJhBISL7UVHUs?=
 =?us-ascii?Q?rOB/xIo1gpd8Wh1JrxwLFKOwd3p4UvE0MWa1TDSoiqQeoTsc970UbL/GQArg?=
 =?us-ascii?Q?0F6/2O/cx1UpBGqXGRb5Ye85yj3MXQtqgyM5HPkgf/C81ltOGo5Da3tIYbxt?=
 =?us-ascii?Q?q3yR+sPDqF9d0e+bLIZRka9ILjHRb3BmmP6tACbD7A28QhcQIZHHhI1iQWrr?=
 =?us-ascii?Q?AuUsZuxQ/FwhrlspcBy+f+nOBU7DnE6NdC1sK1iVZGWCaqTQah9wlHnV9qVB?=
 =?us-ascii?Q?sJgTC8ygkkrqHiBTVL32/g7EQp14eieuqo4/8WV555M/zYbgw/jsZDRfzdwe?=
 =?us-ascii?Q?3C/qPeie/PBF4OqV2mSqDbIrFuJocaurbpksAuOix0RmHY1f9fOqpFVG9y+O?=
 =?us-ascii?Q?ny/yi6s3xrrV3xcXa+/e1frUS9r2TlVwi3dl4R3s+SpfDXGGELzUX9XIghYp?=
 =?us-ascii?Q?TOIJm0nxVaBX8q0T+ksS65Otv36wMO7AH+KwLvFLRLwG7mnCYd5Yl3dAssAL?=
 =?us-ascii?Q?pEVEch5+zWICQnqabludVgceXFfJHAUazFtke00Xlw00Wz8/zQM/uBaiqwI0?=
 =?us-ascii?Q?oTUjqhEXHIImrVPMw21EzlLCc4Ly4Gh/MQWWlD8Nt6f81i0y7ZJIWaWeJwws?=
 =?us-ascii?Q?W5/hghlE7VcKwsUYCrRb9RUXIUbcV/FduCs5tlxaw/gCLzWaNOC6dUQz1Lpx?=
 =?us-ascii?Q?hhmdo3+zf/eiMnlE8ruUoPQlUg+HWlODjpXFfS9pbXvdV43Fl9iUrvYcKJq4?=
 =?us-ascii?Q?q4maPtzikN59XSheUAG1g0OJN5Nb9NUj6ToPoRGZ0fJGd2AP2E5RazxdrheL?=
 =?us-ascii?Q?HyLhwcng5boz55OyUg6GV5xY4K0mIv+8h7vHlxoR26rFHsjvkA/jVgjpJ6wo?=
 =?us-ascii?Q?KKsVOK8V91V816AA1isevHBc+jBVptC75D0qh9PSQIHyQuzdBfevsoYAPW3Q?=
 =?us-ascii?Q?8XCwy8IHy7I/cuASUIKDu8qJKpDzmuHZdd/XySQgnJ4Lnf8DvDpnd0psqaaY?=
 =?us-ascii?Q?7FTQNI5dY495MS9tUpH2f84gpt2z+wh7uullYoHYAVoMSI2mdyhTc1Y62zKT?=
 =?us-ascii?Q?jDaSTrlIkSUvdOC/pxKKRDFqpZT5ha5d7KbM1JuX4MnEjsU19Zu0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ba191-ea73-47bb-c510-08ded146e988
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:46:03.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM5cS1fHD5wPHR5zISYydemm4u8hr2nU+aT0Wd8JfiLt1/QTNriAEZv0sP0CeL97Ed8mmnW8X5jtKp4iRx018LgB69nKNiffg8iy/xotKtgkFLOnjgcGf/6hzgPB+SMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

On Tue, Jun 23, 2026 at 05:14:16PM +0530, Shubham Patil wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>
> Add an I3C master driver and maintainers fragment for the AMD I3C bus
> controller.
>
> The driver currently supports the I3C bus operating in SDR mode,
> with features including Dynamic Address Assignment, private data
> transfers, and CCC transfers in both broadcast and direct modes. It
> also supports operation in I2C mode.
>
> The controller's data FIFOs are accessed big-endian; the driver performs
> this conversion locally using ioread32be()/iowrite32be() with the
> helpers, so it does not depend on any core FIFO-endianness helpers.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> ---
...
> +#define XI3C_REV_NUM_MASK			GENMASK(15, 8)
> +#define XI3C_PID1_MASK				GENMASK(15, 0)
> +#define XI3C_FIFO_LEVEL_MASK			GENMASK(15, 0)
> +#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
> +#define XI3C_RESP_CODE_SUCCESS			0	/* Transfer completed OK */
> +#define XI3C_RESP_CODE_NO_TARGET		2	/* 7E NACK: no target on bus */
> +#define XI3C_RESP_CODE_NACK			3	/* Target NACK / CE2 / DAA end */
> +#define XI3C_ADDR_MASK				GENMASK(6, 0)
> +#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
> +
> +/* Command FIFO word layout (bit ranges encoded in the GENMASK/BIT args) */
> +#define XI3C_CMD_TYPE				GENMASK(3, 0)	/* command type */
> +#define XI3C_CMD_TERMINATE			BIT(4)		/* terminate (last cmd of xfer) */
> +#define XI3C_CMD_ADDR				GENMASK(15, 8)	/* target address << 1 | RnW */
> +#define XI3C_CMD_LEN				GENMASK(27, 16)	/* payload length in bytes */
> +#define XI3C_CMD_TID				GENMASK(31, 28)	/* transfer ID */
> +
> +#define XI3C_OD_TLOW_NS				500000
> +#define XI3C_OD_THIGH_NS			41000
> +#define XI3C_I2C_TCASMIN_NS			600000
> +#define XI3C_TCASMIN_NS				260000
> +#define XI3C_MAXDATA_LENGTH			4095
> +#define XI3C_MAX_DEVS				32
> +#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT	8
> +
> +#define XI3C_THOLD_MIN_REV0			5	/* Min SDA hold cycles, rev 0 IP */
> +#define XI3C_THOLD_MIN_REV1			6	/* Min SDA hold cycles, rev >= 1 IP */
> +#define XI3C_CYCLE_ADJUST			2	/* SCL/SDA pre-bias for HW pipeline */
> +#define XI3C_FIFO_RESET_DELAY_US		10	/* HW settling time after FIFO reset */
> +#define XI3C_POLL_INTERVAL_US			10	/* readl_poll_timeout() sleep slice */

Can you provide comment where these value come from, spec, datasheet ...?

> +
> +#define XI3C_I2C_MODE				0
> +#define XI3C_I2C_TID				0
> +#define XI3C_SDR_MODE				1
> +#define XI3C_SDR_TID				1
> +
> +#define XI3C_WORD_LEN				4
> +
> +/*
> + * XI3C_RESP_TIMEOUT_US is in microseconds because it is passed as the
> + * timeout_us argument of readl_poll_timeout(). XI3C_XFER_TIMEOUT_MS is in
> + * milliseconds because it feeds msecs_to_jiffies(). Keep the two units
> + * distinct in the names so callers cannot mix them up.
> + */
> +#define XI3C_RESP_TIMEOUT_US			500000
> +#define XI3C_XFER_TIMEOUT_MS			1000

the same here.

> +
> +struct xi3c_cmd {
> +	const void *tx_buf;
> +	void *rx_buf;
> +	u16 tx_len;
> +	u16 rx_len;
> +	u8 addr;
> +	u8 type;
> +	u8 tid;
> +	bool rnw;
> +	bool is_daa;
> +	bool continued;
> +	enum i3c_error_code err;
> +};
> +
...
> +
> +static void xi3c_master_reset_fifos(struct xi3c_master *master)
> +{
> +	u32 data;
> +
> +	/* Assert FIFO reset. */
> +	data = ioread32(master->membase + XI3C_RESET_OFFSET);
> +	data |= XI3C_FIFOS_RST_MASK;
> +	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
> +	/* Read-back flushes the posted write before the settling delay below. */
> +	ioread32(master->membase + XI3C_RESET_OFFSET);
> +	udelay(XI3C_FIFO_RESET_DELAY_US);

now suggest use fsleep()

> +
> +	/* De-assert FIFO reset, then wait for the FIFOs to come back up. */
> +	data &= ~XI3C_FIFOS_RST_MASK;
> +	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
> +	ioread32(master->membase + XI3C_RESET_OFFSET);
> +	udelay(XI3C_FIFO_RESET_DELAY_US);
> +}
> +
> +static inline void xi3c_master_init(struct xi3c_master *master)
> +{
> +	/* Reset fifos */
> +	xi3c_master_reset_fifos(master);
> +
> +	/* Enable controller */
> +	xi3c_master_enable(master);
> +}
> +
> +static inline void xi3c_master_reinit(struct xi3c_master *master)
> +{
> +	/* Reset fifos */
> +	xi3c_master_reset_fifos(master);
> +
> +	/* Resume controller */
> +	xi3c_master_resume(master);
> +}
> +
> +static struct xi3c_xfer *xi3c_master_alloc_xfer(unsigned int ncmds)
> +{
> +	struct xi3c_xfer *xfer;
> +
> +	xfer = kzalloc(struct_size(xfer, cmds, ncmds), GFP_KERNEL);

ues new API,  kzalloc_flex()

> +	if (!xfer)
> +		return NULL;
> +
> +	xfer->ncmds = ncmds;
> +
> +	return xfer;
> +}
> +
> +static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
> +					struct xi3c_cmd *cmd)
> +{
> +	u16 rx_data_available;
> +	u16 copy_len;
> +	u16 len;
> +
> +	rx_data_available = xi3c_rd_fifo_level(master);
> +	len = rx_data_available * XI3C_WORD_LEN;
> +
> +	if (!len)
> +		return;
> +
> +	copy_len = min_t(u16, len, cmd->rx_len);

now need't min_t, just min

> +	xi3c_readl_fifo(master->membase + XI3C_RD_FIFO_OFFSET,
> +			(u8 *)cmd->rx_buf, copy_len);
> +
> +	cmd->rx_buf = (u8 *)cmd->rx_buf + copy_len;
> +	cmd->rx_len -= copy_len;
> +}
> +
...
> +
> +	timeout = jiffies + msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS);
> +
> +	/* Read data from rx fifo */
> +	while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(master->dev, "XI3C read timeout\n");
> +			return -EIO;
> +		}
> +		xi3c_master_rd_from_rx_fifo(master, cmd);
> +		usleep_range(XI3C_POLL_INTERVAL_US, 2 * XI3C_POLL_INTERVAL_US);
> +	}

can you use read_poll_timeout macro?

> +
> +	/* Read remaining data */
> +	xi3c_master_rd_from_rx_fifo(master, cmd);
> +
> +	return 0;
> +}
> +
...
> +
> +	for (i = 0; i < master->daa.index; i++) {
> +		u64 pid;
> +
> +		ret = i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
> +		if (ret)
> +			goto err_daa;


https://lore.kernel.org/linux-i3c/20260608054312.10604-7-adrian.hunter@intel.com/T/#u
which defer add i3c device.

And don't check error here, because one device add failure should not impact
other following devices.

Frank
> +
> +		pid = FIELD_GET(XI3C_PID_MASK,
> +				get_unaligned_be64(pid_bufs[i]));
> +		dev_dbg(master->dev, "Client %d: PID: 0x%llx\n", i, pid);
> +	}
> +
> +	return 0;
> +
> +err_daa:
> +	xi3c_master_reinit(master);
> +	return ret;
> +}
> +
...
> +static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
> +					   struct i3c_ccc_cmd *ccc)
> +{
> +	struct xi3c_xfer *xfer __free(kfree) = NULL;
> +	u8 *buf __free(kfree) = NULL;
> +	struct xi3c_cmd *cmd;
> +	u16 xfer_len;
> +	int ret;
> +
> +	if (ccc->dests[0].payload.len >= XI3C_MAXDATA_LENGTH)
> +		return -EINVAL;
> +
> +	xfer_len = ccc->dests[0].payload.len + 1;
> +
> +	xfer = xi3c_master_alloc_xfer(1);
> +	if (!xfer)
> +		return -ENOMEM;
> +
> +	buf = kmalloc(xfer_len, GFP_KERNEL);

kmalloc_obj

Frank
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf[0] = ccc->id;
> +	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
> +
> +	cmd = &xfer->cmds[0];
> +	cmd->addr = ccc->dests[0].addr;
> +	cmd->rnw = ccc->rnw;
> +	cmd->tx_buf = buf;
> +	cmd->tx_len = xfer_len;
> +	cmd->type = XI3C_SDR_MODE;
> +	cmd->tid = XI3C_SDR_TID;
> +	cmd->continued = false;
> +
> +	ret = xi3c_master_common_xfer(master, xfer);
> +	ccc->err = cmd->err;
> +
> +	return ret;
> +}
